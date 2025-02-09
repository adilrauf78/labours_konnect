import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/location_controller/location_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmLocation extends StatefulWidget {
  const ConfirmLocation({super.key});

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  final LocationController locationController = Get.put(LocationController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: locationController.onMapCreated,
            markers: Set<Marker>.of(locationController.markers),
            initialCameraPosition: CameraPosition(
              target: locationController.initialPosition,
              zoom: 9.0,
            ),
            compassEnabled: false,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // Disable the default my location button
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateBackWithAnimation(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                        color: AppColor.black,
                        size: 18,
                      ),
                    ),
                    SubText(text: 'Cancel',
                      fontSize: 16..sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD40000),
                    ),
                  ],
                ),
                SizedBox(height: 20..h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45..h,
                  child: GooglePlaceAutoCompleteTextField(
                    focusNode: locationController.focusNode,
                    textEditingController: locationController.controller,
                    boxDecoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                            color: AppColor.black.withOpacity(.25),
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    googleAPIKey: "AIzaSyDEztc5VQY5Le2KhQXYm--l8Wvkswzr9RQ",
                    inputDecoration: InputDecoration(
                      hintText: "Search your location",
                      hintStyle: TextStyle(
                          color: Color(0xFF4A4949),
                          fontSize: 14..sp,
                          fontWeight: FontWeight.w500
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 25,
                        minWidth: 25,
                      ),
                      prefixIcon : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('${iconPath}location.svg'),
                      ),
                    ),
                    debounceTime: 400,
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      LatLng latLng = LatLng(double.parse(prediction.lat ?? '0'), double.parse(prediction.lng ?? '0'));
                      locationController.controller.text = prediction.description ?? "";
                      FocusScope.of(context).unfocus();
                      locationController.updateMapLocation(latLng);
                      print("placeDetails" + prediction.lat.toString());
                    },
                    containerVerticalPadding: 0,
                    containerHorizontalPadding: 0,
                    itemClick: (Prediction prediction) {
                      locationController.controller.text = prediction.description ?? "";
                      locationController.controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description?.length ?? 0));
                    },
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColor.white
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svgIcons/location.svg'),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(child: Text("${prediction.description ?? ""}",
                              style: TextStyle(
                                  color: Color(0xFF4A4949),
                                  fontSize: 14..sp,
                                  fontWeight: FontWeight.w500
                              ),
                            ))
                          ],
                        ),
                      );
                    },

                    isCrossBtnShown: true,

                    // default 600 ms ,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GestureDetector(
                onTap: () async {
                  await authController.fetchAndStoreUserData();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', true);
                  Get.offAll(BottomNavigator());
                },
                child: Button(
                    text: 'Confirm Location'),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: SizedBox(
              width: 50..w,
              height: 50..h,
              child: FloatingActionButton(
                backgroundColor: AppColor.white,
                child: locationController.isLoading.value
                    ? Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColor.blue,
                    ),
                  ),
                )
                    : Icon(Icons.my_location),
                onPressed: locationController.getCurrentLocation,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
