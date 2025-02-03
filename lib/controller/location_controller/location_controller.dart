import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/view/auth_screens/confirm_location/confirm_location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController{
  bool isLoading =  false;


  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late GoogleMapController mapController;
  LatLng initialPosition = LatLng(31.5204, 74.3587);
  late LatLng _currentPosition;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getCurrentLocation() async {
      isLoading = true;
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
    } catch (e) {
      print("Error getting location: $e");
    } finally {
        isLoading = false;
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
    isLoading = true;
    update();
    var status = await Permission.location.request();
    isLoading = false;
    update();

    if (status.isGranted) {
      SuccessSnackBar('Permission Granted', 'Location access enabled.');
      Get.off(ConfirmLocation());
      await getCurrentLocation();
    } else if (status.isDenied) {
      ErrorSnackBar('Permission Denied', 'Please enable location access.');
    } else if (status.isPermanentlyDenied) {
      ErrorSnackBar('Permission Denied', 'Go to settings to enable location access.');
      await openAppSettings();
    }
  }


}