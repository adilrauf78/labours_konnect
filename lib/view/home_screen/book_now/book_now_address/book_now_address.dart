import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/location_controller/location_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/book_now/book_now_checkout/book_now_checkout.dart';
import 'package:labours_konnect/view/vendor/add_services/add_services.dart';

class BookNowAddress extends StatefulWidget {
  final AddServices services;
  const BookNowAddress({super.key, required this.services});

  @override
  State<BookNowAddress> createState() => _BookNowAddressState();
}

class _BookNowAddressState extends State<BookNowAddress> {
  final LocationController locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateBackWithAnimation(context);
                    },
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColor.black,
                      size: 18,
                    ),
                  ),
                  MainText(
                    text: 'Booking',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
            ),
            SizedBox(height: 30..h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '1',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Detail',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10..w),
                  Container(
                    width: 25..w,
                    height: 2..h,
                    decoration: BoxDecoration(
                      color: AppColor.k0xFF818080,
                    ),
                  ),
                  SizedBox(width: 12..w),
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '2',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Address',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10..w),
                  Container(
                    width: 25..w,
                    height: 2..h,
                    decoration: BoxDecoration(
                      color: AppColor.k0xFF818080,
                    ),
                  ),
                  SizedBox(width: 12..w),
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '3',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Checkout',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 25..h),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*.55,
                  child: GoogleMap(
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
                    myLocationButtonEnabled: false,
                  ),
                ),
                Positioned(
                  top: 20,
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
            SizedBox(height: 20..h),
            Center(
              child: SubText(
                text: 'Confirm your Location',
                fontSize: 16..sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15..r),
                  color: AppColor.black.withOpacity(.1),
                ),
                child: Obx(() => Text16(
                  text: locationController.address.value,
                )),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, BookNowCheckout(service: widget.services,));
                },
                child: Button(
                  text: 'Next',
                ),
              ),
            ),
            SizedBox(height: 20..h),
          ],
        ),
      ),
    );
  }
}
