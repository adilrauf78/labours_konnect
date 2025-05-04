import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/review_controller/review_controller.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_services/service_details/service_details.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  final ServiceController serviceController = Get.find<ServiceController>();
  final AuthController authController = Get.find<AuthController>();
  final ReviewController reviewController = Get.put(ReviewController());
  double _rating = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(VendorBottomNavigator());
                  },
                  child: Icon(Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18,
                  ),
                ),
                MainText(
                  text: 'My Services',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 30..h),
            Expanded(
              child: FutureBuilder<List<AddServicesModel>>(
                future: serviceController.fetchServicesForUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No services found"));
                  }

                  final services = snapshot.data!;
                  return ListView.builder(
                    itemCount: services.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: (){
                            navigateToNextScreen(context, ServiceDetails(service: service));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10..r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.k0xFFEEEEEE,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 160..h,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10..r),
                                      topRight: Radius.circular(10..r),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.k0xFFEEEEEE,
                                        blurRadius: 5,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: serviceController.imagePath.isNotEmpty
                                          ? NetworkImage(serviceController.imagePath.value)
                                          : AssetImage('${imagePath}pipe-fitting.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SubText(
                                        text: service.serviceTitle,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16..sp,
                                      ),
                                      SizedBox(height: 10..h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 34..w,
                                                height: 34..h,
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
                                                    text: authController.fullName.value.isNotEmpty
                                                        ? authController.fullName.value
                                                        : "null",
                                                    fontSize: 14..sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  FutureBuilder<double>(
                                                    future: reviewController.getAverageRating(service.id),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return MainText(
                                                          text: '...',
                                                          fontSize: 15..sp,
                                                          fontWeight: FontWeight.w500,
                                                        );
                                                      }
                                                      if (snapshot.hasError) {
                                                        return MainText(
                                                          text: '0.0',
                                                          fontSize: 15..sp,
                                                          fontWeight: FontWeight.w500,
                                                        );
                                                      }
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: snapshot.data ?? 0.0,
                                                            itemCount: 5,
                                                            itemSize: 12,
                                                            itemPadding: EdgeInsets.only(right: 2),
                                                            direction: Axis.horizontal,
                                                            unratedColor: Color(0xFFF9E005).withOpacity(.5),
                                                            itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                                                          ),
                                                          SizedBox(width: 5..w),
                                                          Text(
                                                            snapshot.data!.toStringAsFixed(1),
                                                            style: TextStyle(
                                                              color: AppColor.black,
                                                              fontSize: 10..sp,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 13,vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.circular(5..r),
                                            ),
                                            child: Center(
                                              child: MainText(
                                                text: '\$ ${service.price}',
                                                fontSize: 14..sp,
                                                color: AppColor.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20..h),
          ],
        ),
      ),
    );
  }
}
