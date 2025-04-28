import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/view/auth_screens/confirm_location/confirm_location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController{
  RxBool isLoading = false.obs;
  RxString locationText = "Fetching location...".obs;

  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late GoogleMapController mapController;
  LatLng initialPosition = LatLng(31.5204, 74.3587);
  late LatLng _currentPosition;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  RxString homeAddress = "Fetching location...".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Future<void> getLiveLocation() async {
    isLoading.value = true;

    var status = await Permission.location.status;
    if (!status.isGranted) {
      await requestLocationPermission();
      status = await Permission.location.status;
      if (!status.isGranted) {
        address.value = "Location permission not granted.";
        isLoading.value = false;
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        address.value =
        '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      } else {
        address.value = "Address not found.";
      }
    } catch (e) {
      print("Error fetching location: $e");
      address.value = "Error fetching location.";
    } finally {
      isLoading.value = false;
    }
  }
  //Floating Action Button Click Location in Text Show
  RxString address = 'H#28 saleem Street # 17 Fiji garhi stop Band Rd, Shera Kot, Lahore, Punjab 54000 Pakistan'.obs;
  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    // Check if location permission is granted
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await requestLocationPermission();
      status = await Permission.location.status;
      if (!status.isGranted) {
        isLoading.value = false;
        ErrorSnackBar('Permission Denied', 'Please enable location access to use this feature.');
        return;
      }
    }
    isLoading.value = true;

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        _currentPosition = LatLng(position.latitude, position.longitude);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition,
            zoom: 15.0,
          ),
        ),
      );
      isLoading.value = false;
      //ya baad ma kia ha
      // Coordinates ko address mein convert karein
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        address.value = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
      }
      isLoading.value = false;
    } catch (e) {
      print("Error getting location: $e");
    } finally {
      isLoading.value = false;
    }
  }

  final List<Marker> markers =  <Marker>[];
  List<Marker> list = const [
    Marker(
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(
            title: 'My Current Location'
        )
    ),
  ];


  void updateMapLocation(LatLng latLng) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 10.0,
    )));
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('selected_location'),
        position: latLng,
        infoWindow: InfoWindow(title: 'Selected Location'),
      ),);
  }








  Future<void> requestLocationPermission() async {
    isLoading.value = true;
    update();
    var status = await Permission.location.request();
    isLoading.value = false;
    update();

    if (status.isGranted) {
      SuccessSnackBar('Permission Granted', 'Location access enabled.');
      await getCurrentLocation();
    } else if (status.isDenied) {
      ErrorSnackBar('Permission Denied', 'Please enable location access.');
    } else if (status.isPermanentlyDenied) {
      ErrorSnackBar('Permission Denied', 'Go to settings to enable location access.');
      await openAppSettings();
    }
  }


}