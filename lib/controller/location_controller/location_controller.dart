import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
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
  // Add these variables to store coordinates
  RxDouble selectedLatitude = 0.0.obs;
  RxDouble selectedLongitude = 0.0.obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  String currentLocation = 'Detecting location...';
  Future<void> handleLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
          currentLocation = 'Location services are disabled.';
        return;
      }

      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        _getAddressFromPosition(position);
      });
    } else {
        currentLocation = 'Location permission not granted.';
    }
  }

  Future<void> _getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placemark = placemarks.first;

        currentLocation =
        '${placemark.street},${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';

    } catch (e) {
        currentLocation = 'Failed to get address.';
    }
  }

  //Floating Action Button Click Location in Text
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
      // Store the coordinates
      selectedLatitude.value = position.latitude;
      selectedLongitude.value = position.longitude;

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
        address.value = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
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
    // Update selected coordinates
    selectedLatitude.value = latLng.latitude;
    selectedLongitude.value = latLng.longitude;

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

  // Add this method to LocationController
  Future<void> getNearbyServices() async {
    try {
      isLoading.value = true;

      // First get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = LatLng(position.latitude, position.longitude);

      // Update map to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition,
            zoom: 15.0,
          ),
        ),
      );

      // Get nearby services (20 km radius)
      final serviceController = Get.find<ServiceController>();
      final nearbyServices = await serviceController.fetchNearbyServices(
        position.latitude,
        position.longitude,
        20, // 20 km radius
      );

      // You can now use nearbyServices as needed
      // For example, show them in a list or on the map
      print('Found ${nearbyServices.length} nearby services');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      ErrorSnackBar('Error', 'Failed to get nearby services: $e');
    }
  }

}