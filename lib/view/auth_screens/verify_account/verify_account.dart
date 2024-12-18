import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/user_details/user_details.dart';
import 'package:pinput/pinput.dart';

class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h,),
              GestureDetector(
                onTap: () {
                  navigateBackWithAnimation(context);
                },
                child: Icon(Icons.arrow_back_ios,
                  color: AppColor.black,
                  size: 18,
                ),
              ),
              SizedBox(height: 30..h,),
              Center(
                child: Text('Logo',
                  style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black
                  ),
                ),
              ),
              SizedBox(height: 85..h,),
              MainText(
                  text: 'Verify Account',
              ),
              SubText(
                  text: 'Please type the verification code send to dummy@email.com',
              ),
              // Text(
              //   _authController.maskEmail(_authController.emailController.text),
              //   style: TextStyle(
              //       fontSize: 13,
              //       fontWeight: FontWeight.w500,
              //       color: AppColors.subColor
              //   ),
              // ),
              SizedBox(height: 20..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Pinput(
                      length: 4,
                      preFilledWidget: Text('-',
                        style: TextStyle(
                          color: Color(0xFF535353),
                          fontWeight: FontWeight.w400,
                          fontSize: 34..sp,
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 58..w,
                        height: 58..h,
                        textStyle: TextStyle(
                          fontSize: 20..sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20..r),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Color(0xFFE5E5E5)
                            ),
                          ],
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: 58..w,
                        height: 58..h,
                        textStyle: TextStyle(
                          fontSize: 20..sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(20..r),
                        ),
                      ),
                      followingPinTheme: PinTheme(
                        width: 58..w,
                        height: 58..h,
                        textStyle: TextStyle(
                          fontSize: 20..sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20..r),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Color(0xFFE5E5E5)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                      },
                      child:  SubText(
                        text: 'Resend Code in : 59',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF454F5B),
                      )
                  ),
                ],
              ),
              SizedBox(height: 50..h,),
              GestureDetector(
                  onTap: () {
                    navigateToNextScreen(context, UserDetails());
                  },
                  child: Button(
                      text: 'Verify Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
