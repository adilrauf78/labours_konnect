import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/category_controller/category_controller.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/categories/categories.dart';
import 'package:labours_konnect/view/vendor/add_services/select_map/select_map.dart';

class AddServices extends StatefulWidget {
  final String? address;

  const AddServices({super.key, this.address});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  final CategoryController categoryController = Get.put(CategoryController());
  final ServiceController serviceController = Get.put(ServiceController());



  @override
  void initState() {
    super.initState();
    serviceController.locationController = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    serviceController.locationController.dispose();
    super.dispose();
  }

  List<File?> images = [];
  File? image2;

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

  pickImage(ImageSource Imagetype, String imagefirst) async {
    final image = await ImagePicker().pickImage(source: Imagetype);
    if (image == null) return;
    final imagetemp = File(image.path);
    if (imagefirst == 'review') {
      this.image2 = imagetemp;
      setState(() => images.add(imagetemp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_authController) {
      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55
                ..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
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
                      text: 'Add Services',
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 20
                      ..w),
                  ],
                ),
              ),
              SizedBox(height: 30
                ..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text16(
                      text: 'Slider Images',
                      color: AppColor.black,
                    ),
                    GestureDetector(
                      onTap: () => imagePickerOption('review'),
                      child: Container(
                        width: 40
                          ..w,
                        height: 40
                          ..h,
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
                          child: Icon(Icons.add_outlined, color: AppColor.black,
                            size: 30,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: images.length,
              //   padding: EdgeInsets.zero,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 10),
              //       child: Stack(
              //         children: [
              //           Container(
              //             height: 100.h,
              //             width: 100.w,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: images != null
              //                 ? ClipRRect(
              //               borderRadius: BorderRadius.circular(8),
              //               child: Container(
              //                 width: 100.w,
              //                 height: 100.h,
              //                 child: Image.file(
              //                   images[index]!,
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             )
              //                 : Container(),
              //           ),
              //           Positioned(
              //             top: 2.h,
              //             right: 2.w,
              //             child: GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   images.removeAt(index);
              //                 });
              //               },
              //               child: Container(
              //                 height: 20.h,
              //                 width: 20.w,
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   shape: BoxShape.circle,
              //                 ),
              //                 child: Center(
              //                   child: Icon(
              //                     Icons.close_rounded,
              //                     color: AppColor.black,
              //                     size: 15,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: 40
                ..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text16(
                      text: 'Service Title',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50
                        ..h,
                      child: TextField(
                        controller: serviceController.serviceTitle,
                        cursorColor: AppColor.black.withOpacity(.5),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          fillColor: AppColor.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: AppColor.black.withOpacity(.5),
                            fontSize: 15
                              ..sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Text16(
                      text: 'Category*',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    GestureDetector(
                      onTap: () async {
                        final selected = await Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                            Categories(isFromFilter: true),),);
                        if (selected != null) {
                          serviceController.updateSelectedCategory(selected);
                        }
                      },
                      child: Obx(() => Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 50
                            ..h,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(
                              color: Color(0xFFEEEEEE),
                            ),
                            borderRadius: BorderRadius.circular(10
                              ..r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubText(
                                text: serviceController.selectedCategory.value,
                                color: AppColor.black.withOpacity(.5),
                                fontWeight: FontWeight.w400,
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined,
                                color: AppColor.black.withOpacity(.25),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Text16(
                      text: 'Sub-Category(Optional)',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50
                        ..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                          color: Color(0xFFEEEEEE),
                        ),
                        borderRadius: BorderRadius.circular(10
                          ..r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubText(
                            text: 'Select Sub-Category',
                            color: AppColor.black.withOpacity(.5),
                            fontWeight: FontWeight.w400,
                          ),
                          Icon(Icons.keyboard_arrow_down_outlined,
                            color: AppColor.black.withOpacity(.25),)
                        ],
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Text16(
                      text: 'City',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50
                        ..h,
                      child: TextField(
                        controller: serviceController.cityController,
                        cursorColor: AppColor.black.withOpacity(.5),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          fillColor: AppColor.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: AppColor.black.withOpacity(.5),
                            fontSize: 15
                              ..sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16(
                          text: 'Service Address',
                          color: AppColor.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateToNextScreen(context, SelectMap());
                          },
                          child: Text16(
                            text: 'Select on map',
                            color: AppColor.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10
                      ..h),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 100
                        ..h,
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
                      child: TextField(
                        maxLines: null,
                        controller: serviceController.locationController,
                        cursorColor: Color(0xFF9FA3A8),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Enter your Address',
                          hintStyle: TextStyle(
                            fontSize: 14
                              ..sp,
                            color: AppColor.black.withOpacity(.5),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10..h),
                    Text16(
                      text: 'Phone*',
                      color: AppColor.black,
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
                                serviceController.selectedCountryCode = code.dialCode!;
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
                              controller: serviceController.phoneController,
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
                    SizedBox(height: 10..h),
                    Text16(
                      text: 'Experience Year*',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50
                        ..h,
                      child: TextField(
                        controller: serviceController.experienceController,
                        cursorColor: AppColor.black.withOpacity(.5),
                        keyboardType: TextInputType.number,
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          fillColor: AppColor.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: AppColor.black.withOpacity(.3),
                            fontSize: 15
                              ..sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Text16(
                      text: 'Price*',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50
                        ..h,
                      child: TextField(
                        controller: serviceController.priceController,
                        cursorColor: AppColor.black.withOpacity(.5),
                        keyboardType: TextInputType.number,
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          fillColor: AppColor.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color: AppColor.black.withOpacity(.3),
                            fontSize: 15
                              ..sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20
                      ..h),
                    Text16(
                      text: 'Description*',
                      color: AppColor.black,
                    ),
                    SizedBox(height: 10
                      ..h),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200
                        ..h,
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
                      child: TextField(
                        controller: serviceController.descriptionController,
                        maxLines: null,
                        cursorColor: Color(0xFF9FA3A8),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          labelStyle: TextStyle(
                            fontSize: 14
                              ..sp,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(
                            fontSize: 14
                              ..sp,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14
                            ..sp,
                          color: AppColor.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 30
                      ..h),
                    serviceController.isLoading
                        ? SpinKitRing(
                      color: AppColor.blue,
                      size: 40,
                      lineWidth: 4,
                    )
                        : GestureDetector(
                      onTap: () {
                        serviceController.addService();
                      },
                      child: Button(
                        text: 'Submit',
                      ),
                    ),
                    SizedBox(height: 30
                      ..h),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
