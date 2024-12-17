import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${imagePath}onboarding.png'),
                fit: BoxFit.cover,
              )
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 25,bottom: 10,right: 10,left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30..r),
                  topRight: Radius.circular(30..r),
                ),
                color: AppColor.white
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 25..w,
                          height: 10..h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30..r),
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(width: 5..w),
                        Container(
                          width: 15..w,
                          height: 10..h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30..r),
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        SizedBox(width: 5..w),
                        Container(
                          width: 15..w,
                          height: 10..h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30..r),
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30..h),
                  Center(
                    child: MainText(
                      text: 'Qualified Professionals',
                    ),
                  ),
                  SizedBox(height: 15..h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Search from a list of qualified professionals around you as we bring the best for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15..sp,
                        color: AppColor.black.withOpacity(.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30..h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
