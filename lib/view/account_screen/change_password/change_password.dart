import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool obscureText = true;
  bool obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_authController) {
      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55
                  ..h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),
                SizedBox(height: 20
                  ..h),
                MainText(
                  text: 'Change Password',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 5
                  ..h),
                Text15(
                  text: 'Enter your new password here',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20
                  ..h),
                SizedBox(height: 20
                  ..h,),
                Text15(
                  text: 'Password',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10
                  ..h,),
                SizedBox(
                  height: 45
                    ..h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TextField(
                    controller: _authController.newPasswordController,
                    cursorColor: AppColor.black.withOpacity(.5),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10
                            ..r),
                          borderSide: BorderSide(
                            color: Color(0xFFEEEEEE),
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10
                            ..r),
                          borderSide: BorderSide(
                            color: Color(0xFFEEEEEE),
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.white,
                      filled: true,
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset('${iconPath}lock.svg')),
                      hintStyle: TextStyle(
                        fontSize: 15
                          ..sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.borderColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Color(0xFF9FA3A8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20
                  ..h,),
                Text15(
                  text: 'Confirm Password',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10
                  ..h,),
                SizedBox(
                  height: 45
                    ..h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TextField(
                    controller: _authController.confirmPasswordController,
                    cursorColor: AppColor.black.withOpacity(.5),
                    obscureText: obscureText1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10
                            ..r),
                          borderSide: BorderSide(
                            color: Color(0xFFEEEEEE),
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10
                            ..r),
                          borderSide: BorderSide(
                            color: Color(0xFFEEEEEE),
                          )
                      ),
                      contentPadding: EdgeInsets.zero,
                      fillColor: AppColor.white,
                      filled: true,
                      prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset('${iconPath}lock.svg')),
                      hintStyle: TextStyle(
                        fontSize: 15
                          ..sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.borderColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText1 = !obscureText1;
                          });
                        },
                        child: Icon(
                          obscureText1 ? Icons.visibility_off : Icons
                              .visibility,
                          color: Color(0xFF9FA3A8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30
                  ..h,),
                _authController.isLoading
                    ? SpinKitRing(
                  color: AppColor.blue,
                  size: 40,
                  lineWidth: 4,
                ) : GestureDetector(
                  onTap: () {
                    _authController.changePassword();
                  },
                  child: Button(
                    text: 'Verify',
                  ),
                ),
                SizedBox(height: 20
                  ..h,),
              ],
            ),
          ),
        ),
      );
    });
  }
}
