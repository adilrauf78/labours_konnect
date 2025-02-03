import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/location_controller/location_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class EnableLocation extends StatefulWidget {
  const EnableLocation({super.key});

  @override
  State<EnableLocation> createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocation> {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('${iconPath}enable_location.svg',
                    height: 170
                      ..h,
                    width: 140
                      ..w,
                  ),
                  SizedBox(height: 40
                    ..h,),
                  MainText(
                    text: 'Enable Your Location',
                    fontSize: 28
                      ..sp,
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Choose your location to start find the request around you.',
                      style: TextStyle(
                          fontSize: 14
                            ..sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black.withOpacity(.25),
                          overflow: TextOverflow.fade
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 50
                    ..h,),
                  locationController.isLoading
                      ? SpinKitRing(
                    color: AppColor.blue,
                    size: 40,
                    lineWidth: 4,
                  ) : GestureDetector(
                      onTap: () {
                        locationController.requestLocationPermission();
                      },
                      child: Button(text: 'Enable your Location')),
                ],
              ),
              Positioned(
                top: 55
                  ..h,
                child: GestureDetector(
                  onTap: () {
                    navigateBackWithAnimation(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
