import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool favorite1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
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
                          image: AssetImage('${imagePath}pipe-fitting.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 55,
                right: 20,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateBackWithAnimation(context);
                      },
                      child: Container(
                        width: 40..w,
                        height:40..h,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.k0xFFEEEEEE,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios,
                            color: AppColor.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          favorite1 = !favorite1;
                        });
                      },
                      child: Container(
                        width: 40..w,
                        height: 40..h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.k0xFFEEEEEE,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                            child: favorite1 ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 24,) :
                            Icon(Icons.favorite,color: AppColor.red,size: 24,)
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
                        text: 'Pipe Fitting',
                        fontWeight: FontWeight.w700,
                        fontSize: 16..sp,
                      ),
                      SizedBox(height: 5..h),
                      Row(
                        children: [
                          SvgPicture.asset('${iconPath}map-pin.svg'),
                          SizedBox(width: 10..w),
                          Text12(
                            text: 'Woodstock, GA',
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
                                text: '\$ 20.00',
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text16(
                  text: 'Description',
                ),
                SubText(
                  text: 'Hey, I\'m Jack Marston and expert of plumb servicing. I having more than 2 years of working '
                      'experience. I appreciate the best delivery from my side. Hey, I\'m Jack Marston and expert of plumb '
                      'servicing. I having more than 2 years of working experience Read More...',
                  fontSize: 12..sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 30..h),
        ],
      ),
    );
  }
}
