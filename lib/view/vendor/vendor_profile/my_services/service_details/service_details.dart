import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';

class ServiceDetails extends StatefulWidget {
  final AddServicesModel service;
  const ServiceDetails({super.key, required this.service});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool favorite1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 435..h,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 365..h,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          image: DecorationImage(
                            image: widget.service.serviceImage != null && widget.service.serviceImage!.isNotEmpty
                                ? NetworkImage(widget.service.serviceImage!) // Use NetworkImage if serviceImage is not null and not empty
                                : AssetImage('${imagePath}pipe-fitting.png') as ImageProvider, // Use default image otherwise
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateBackWithAnimation(context);
                        },
                        child: Center(
                          child: Icon(Icons.arrow_back_ios,
                            color: AppColor.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 15,
                  right: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
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
                        SubText(
                          text: widget.service.serviceTitle,
                          fontWeight: FontWeight.w700,
                          fontSize: 16..sp,
                        ),
                        SizedBox(height: 5..h),
                        SubText(
                          text: widget.service.category,
                          fontWeight: FontWeight.w400,
                          fontSize: 16..sp,
                        ),
                        SizedBox(height: 5..h),
                        Row(
                          children: [
                            SvgPicture.asset('${iconPath}map-pin.svg'),
                            SizedBox(width: 10..w),
                            Expanded(
                              child: Text(
                                widget.service.location.isNotEmpty
                                    ? widget.service.location
                                    : 'Unknown Location',
                                style: TextStyle(
                                  color: AppColor.black.withOpacity(.5),
                                  fontSize: 12..sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5..h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,size: 16,color: Color(0xFFFFD800)),
                                SizedBox(width: 3..w),
                                MainText(
                                  text: '4.5',
                                  fontSize: 15..sp,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 13,vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(5..r),
                              ),
                              child: Center(
                                child: MainText(
                                  text: '\$ ${widget.service.price}',
                                  fontSize: 14..sp,
                                  color: AppColor.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15..h,),
                  Text16(
                    text: 'Description',
                  ),
                  SubText(
                    text: widget.service.description.isNotEmpty
                        ? widget.service.description
                        : 'No description provided',
                    fontSize: 12..sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30..h),
          ],
        ),
      ),
    );
  }
}
