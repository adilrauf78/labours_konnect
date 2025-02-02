import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthController authController = Get.find<AuthController>();

  void imagePickerOption(String imageType) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            color: AppColor.backgroundColor,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.camera, imageType);
                        Get.back();
                      },
                      child: Button(text: 'CAMERA')),
                  SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery, imageType);
                        Get.back();
                      },
                      child: Button(text: 'GALLERY')),
                  SizedBox(height: 10,),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Button(text: 'CANCEL'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  File? image1;

  pickImage(ImageSource Imagetype, String imagefirst) async {
    final image = await ImagePicker().pickImage(source: Imagetype);
    if (image == null) return;
    final imagetemp = File(image.path);
    if (imagefirst == 'Profile') {
      this.image1 = imagetemp;
      setState(() => this.image1 = imagetemp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateBackWithAnimation(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    MainText(
                      text: 'Edit Profile',
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      width: 20
                        ..w,
                    )
                  ],
                ),
                SizedBox(height: 30
                  ..h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 80
                            ..h,
                          width: 80
                            ..w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40
                              ..r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40
                              ..r),
                            child: image1 != null ? Image.file(
                                image1!, fit: BoxFit.cover) : Image.asset(
                              "${imagePath}image.png", fit: BoxFit.fill,),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => imagePickerOption('Profile'),
                            child: Container(
                              padding: EdgeInsets.all(7),
                              height: 30
                                ..h,
                              width: 30
                                ..w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF677294).withOpacity(.8)
                              ),
                              child: SvgPicture.asset('${iconPath}camera.svg'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
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
                    controller: authController.firstNameController,
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
                SizedBox(height: 15
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
                    controller: authController.lastNameController,
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
                SizedBox(height: 15
                  ..h,),
                Text15(
                  text: 'Phone',
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10
                  ..h,),
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
                          initialSelection: "KF",
                        ),
                      ),
                      SizedBox(width: 5
                        ..w),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
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
                          cursorColor: AppColor.black.withOpacity(.5),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '000 000 000',
                            hintStyle: TextStyle(
                              color: AppColor.black.withOpacity(.3),
                              fontSize: 15
                                ..sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 230
                  ..h,),
                authController.isLoading
                    ? SpinKitRing(
                  color: AppColor.blue,
                  size: 40,
                  lineWidth: 4,
                ) : GestureDetector(
                    onTap: () {
                      authController.updateUserName();
                    },
                    child: Button(text: 'Save')),
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
