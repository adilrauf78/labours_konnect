import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/location_controller/location_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/details/details.dart';
import 'package:labours_konnect/view/my_location/service/service.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final LocationController locationController = Get.put(LocationController());
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateBackWithAnimation(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    MainText(
                      text: 'My Location',
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      width: 20..w,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20..h),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.5,
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
                      myLocationButtonEnabled: false, // Disable the default my location button
                    ),
                  ),
                  Positioned(
                    bottom: 20,
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
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20..r),
                  topLeft: Radius.circular(20..r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 2..h,
                    width: 100..w,
                    decoration: BoxDecoration(
                        color: AppColor.black.withOpacity(.25),
                        borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  SizedBox(height: 20..h),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            navigateToNextScreen(context, Service());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? AppColor.primaryColor
                                    : AppColor.white,
                              borderRadius: BorderRadius.circular(10..r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.k0xFFEEEEEE,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 70..w,
                                      height: 70..h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                        image: DecorationImage(
                                          image: AssetImage('${imagePath}pipe.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10..w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MainText(
                                          text: 'Jack Marston',
                                          color: selectedIndex == index
                                              ? AppColor.white
                                              : AppColor.black,
                                          fontSize: 14..sp,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,size: 14,color: Color(0xFFFFD800)),
                                            SizedBox(width: 3..w),
                                            Text12(
                                              text: '4.5',
                                            ),
                                          ],
                                        ),
                                        Text12(
                                          text: 'Pipe Fitting',
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset('${iconPath}map-pin.svg'),
                                            SizedBox(width: 5..w),
                                            Text12(
                                              text: 'Woodstock, GA',
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text16(
                                  text: '\$20.00',
                                  fontWeight: FontWeight.w700,
                                  color: selectedIndex == index
                                      ? AppColor.white
                                      : AppColor.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
