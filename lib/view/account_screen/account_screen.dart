import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/account_screen/change_password/change_password.dart';
import 'package:labours_konnect/view/account_screen/edit_profile/edit_profile.dart';
import 'package:labours_konnect/view/account_screen/favorite_screen/favorite_screen.dart';
import 'package:labours_konnect/view/account_screen/payment_method/payment_method.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_home.dart';

import 'ai_image_analyzer/ai_image_analyzer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthController authController = Get.find<AuthController>();
  
  void _showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16
              ..r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(16
                ..r),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('${iconPath}close.svg',
                        height: 15
                          ..h,
                        width: 15
                          ..w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5
                  ..h),
                SvgPicture.asset('${iconPath}trash.svg'),
                SizedBox(height: 5
                  ..h),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text15(
                      text: 'Are you sure you want to delete this account?',
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                    )
                ),
                SizedBox(height: 25
                  ..h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await authController.deleteAccount();
                        },
                        child: Container(
                          height: 32
                            ..h,
                          width: 90
                            ..w,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Center(
                            child: Text('Yes',
                              style: TextStyle(
                                  fontSize: 16
                                    ..sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 32
                            ..h,
                          width: 90
                            ..w,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.black.withOpacity(.25),
                                    blurRadius: 4
                                )
                              ]

                          ),
                          child: Center(
                            child: Text('No',
                              style: TextStyle(
                                  fontSize: 16
                                    ..sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55
                ..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  MainText(
                    text: 'Account',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20
                    ..w),
                ],
              ),
              SizedBox(height: 20
                ..h),
              Row(
                children: [
                  Container(
                    width: 100
                      ..w,
                    height: 100
                      ..h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColor.primaryColor, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50
                        ..r),
                      child: Image.asset('${imagePath}image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20
                    ..w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() =>
                          MainText(
                            text: authController.fullName.value.isNotEmpty
                                ? authController.fullName.value
                                : "null",
                            fontWeight: FontWeight.w500,
                          ),
                      ),
                      SizedBox(height: 5
                        ..h),
                      Obx(() =>
                      Text12(
                        text: authController.countryCode.value.isNotEmpty && authController.phone.value.isNotEmpty
                            ? '(${authController.countryCode.value}) ${authController.phone.value}'
                            : 'null',
                      ),

                      ),
                      SizedBox(height: 5
                        ..h),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, size: 20, color: AppColor
                              .black.withOpacity(.5),),
                          SizedBox(width: 5
                            ..h,),
                          Obx(() =>
                              Text12(
                                text: authController.email.value.isNotEmpty
                                    ? authController.email.value
                                    : "null",
                              ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 30
                ..h),
              GestureDetector(
                onTap: () {
                  navigateToNextScreen(context, EditProfile());
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10
                      ..r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.k0xFFEEEEEE,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text16(
                        text: 'Edit Profile',
                      ),
                      SvgPicture.asset('${iconPath}arrow_left.svg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15
                ..h),
              GestureDetector(
                onTap: () {
                  navigateToNextScreen(context, ChangePassword());
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10
                      ..r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.k0xFFEEEEEE,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text16(
                        text: 'Change Password',
                      ),
                      SvgPicture.asset('${iconPath}arrow_left.svg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15
                ..h),
              GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, FavoriteScreen());
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10
                      ..r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.k0xFFEEEEEE,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text16(
                        text: 'My Favorite',
                      ),
                      SvgPicture.asset('${iconPath}arrow_left.svg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15
                ..h),
              GestureDetector(
                onTap: () {
                  navigateToNextScreen(context, PaymentMethod(booking: null,));
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10
                      ..r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.k0xFFEEEEEE,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text16(
                        text: 'Payment Methods',
                      ),
                      SvgPicture.asset('${iconPath}arrow_left.svg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15
                ..h),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 45
                  ..h,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10
                    ..r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.k0xFFEEEEEE,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text16(
                      text: 'Switch to Professional',
                    ),
                    Obx(() =>Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          activeColor: AppColor.primaryColor,
                          value: authController.isProfessionalMode.value,
                          onChanged: (value) {
                            authController.toggleSwitch(
                                value, context);
                          },
                        ),
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 15
                ..h),
              GestureDetector(
                onTap: () {
                  //navigateToNextScreen(context, ImageAnalysisScreen());
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45
                    ..h,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10
                      ..r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.k0xFFEEEEEE,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text16(
                        text: 'About us',
                      ),
                      SvgPicture.asset('${iconPath}arrow_left.svg'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25
                ..h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showCustomPopup(context);
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset('${iconPath}delete.svg'),
                      SizedBox(width: 15
                        ..w,),
                      Text16(
                        text: 'Delete Account',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFD8333E),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25
                ..h),
              GestureDetector(
                onTap: () async {
                  await authController.SignOut();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('${iconPath}logout.svg'),
                      SizedBox(width: 15
                        ..w,),
                      MainText(
                        text: 'Logout',
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30
                ..h),
            ],
          ),
        ),
      ),
    );
  }
}
