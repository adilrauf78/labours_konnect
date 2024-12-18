import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('${imagePath}onboarding2.png'),
                  fit: BoxFit.cover,
                )
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 25,bottom: 35,right: 20,left: 20),
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
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                        SizedBox(width: 5..w),
                        Container(
                          width: 25..w,
                          height: 10..h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30..r),
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30..h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Text(
                        'Let’s Find your Professional',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24..sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30..h),
                  GestureDetector(
                    onTap:(){
                      navigateToNextScreen(context, SignInScreen());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50..h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(100..r),
                      ),
                      child: Center(
                        child: MainText(
                          text: 'Get Started',
                          color: AppColor.white,
                        ),
                      ),
                    ),
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
