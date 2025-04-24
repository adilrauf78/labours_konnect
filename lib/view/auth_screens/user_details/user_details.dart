import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:labours_konnect/view/auth_screens/enable_location/enable_location.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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
                  ..h,),
                GestureDetector(
                  onTap: () {
                    navigateBackWithAnimation(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18
                      ..sp,
                  ),
                ),
                SizedBox(height: 20
                  ..h,),
                MainText(
                  text: 'Lets Get Started',
                ),
                SubText(
                  text: 'Enter the following details to create account',
                ),
                SizedBox(height: 20
                  ..h,),
                Text15(
                  text: 'First Name',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10
                  ..h,),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  child: TextField(
                    controller: _authController.firstName,
                    cursorColor: AppColor.black.withOpacity(.5),
                    keyboardType: TextInputType.name,
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
                          scale: 0.45,
                          child: SvgPicture.asset(
                              '${iconPath}person.svg'),
                        ),
                        hintStyle: TextStyle(
                          color: AppColor.black.withOpacity(.3),
                          fontSize: 15
                            ..sp,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20
                  ..h,),
                Text15(
                  text: 'Last Name',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10
                  ..h,),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  child: TextField(
                    controller: _authController.lastName,
                    cursorColor: AppColor.black.withOpacity(.5),
                    keyboardType: TextInputType.name,
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
                          scale: 0.45,
                          child: SvgPicture.asset(
                              '${iconPath}person.svg'),
                        ),
                        hintStyle: TextStyle(
                          color: AppColor.black.withOpacity(.3),
                          fontSize: 15
                            ..sp,
                          fontWeight: FontWeight.w400,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20..h),
                Text15(
                  text: 'Phone Number',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10..h),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50
                    ..h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10
                        ..r),
                      color: AppColor.white,
                      border: Border.all(
                        color: Color(0xFFEEEEEE),
                      )
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .25,
                        child: CountryCodePicker(
                          // flagWidth: 90,
                          padding: const EdgeInsets.all(0),
                          textStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14
                              ..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          initialSelection: "PK",
                          onChanged: (code) {
                            _authController.selectedCountryCode = code.dialCode!;
                          },
                        ),
                      ),
                      SizedBox(width: 5
                        ..w),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0),
                        child: VerticalDivider(
                          color: Color(0xFF666666),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(width: 5
                        ..w),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .55,
                        child: TextField(
                          controller: _authController.phoneNumber,
                          cursorColor: AppColor.black.withOpacity(
                              .5),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '000 000 000',
                              hintStyle: TextStyle(
                                color: AppColor.black.withOpacity(
                                    .3),
                                fontSize: 15
                                  ..sp,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    controller: _authController.password,
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
                    controller: _authController.cnPassword,
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
                SizedBox(height: 170
                  ..h,),
                _authController.isLoading
                    ? SpinKitRing(
                  color: AppColor.blue,
                  size:40,
                  lineWidth: 4,
                )
                    : GestureDetector(
                    onTap: () {
                      _authController.userDetails();
                    },
                    child: Button(text: 'Submit')),
                SizedBox(height: 20..h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
