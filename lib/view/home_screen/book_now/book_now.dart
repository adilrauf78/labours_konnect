import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/home_screen/book_now/book_now_address/book_now_address.dart';

class BookNow extends StatefulWidget {
  final AddServicesModel service;
  const BookNow({super.key, required this.service});

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  double _rating = 5;
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55..h),
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
                    text: 'Booking',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
            ),
            SizedBox(height: 30..h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '1',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Detail',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10..w),
                  Container(
                    width: 25..w,
                    height: 2..h,
                    decoration: BoxDecoration(
                      color: AppColor.k0xFF818080,
                    ),
                  ),
                  SizedBox(width: 12..w),
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '2',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Address',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10..w),
                  Container(
                    width: 25..w,
                    height: 2..h,
                    decoration: BoxDecoration(
                      color: AppColor.k0xFF818080,
                    ),
                  ),
                  SizedBox(width: 12..w),
                  Container(
                    width: 30..w,
                    height: 30..h,
                    decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(.25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text18(
                        text: '3',
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Text16(
                    text: 'Checkout',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10..r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.k0xFFEEEEEE,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5..h),
                    Row(
                      children: [
                        Container(
                          width: 40..w,
                          height: 40..h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            image: DecorationImage(
                              image: AssetImage('${imagePath}pipe.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10..w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: widget.service.userName ?? 'null',
                              fontSize: 15..sp,
                            ),
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
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: AppColor.black.withOpacity(.1),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 125..w,
                          height: 110..h,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            image: DecorationImage(
                              image: AssetImage('${imagePath}pipe-fitting.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10..r),
                          ),
                        ),
                        SizedBox(width: 10..w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5..h),
                            SubText(
                              text: widget.service.serviceTitle,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 3..h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                    initialRating: 5,
                                    minRating: 1,
                                    itemCount: 5,
                                    itemSize: 16,
                                    itemPadding: EdgeInsets.only(right: 2),
                                    direction: Axis.horizontal,
                                    unratedColor: Color(0x4DF9E005),
                                    itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                                    onRatingUpdate: (rating1){
                                      setState(() {
                                        _rating = _rating;
                                      });
                                    }
                                ),
                                SizedBox(width: 5..w),
                                Text(
                                  '$_rating',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 14..sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10..h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 25..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                text: 'Booking Date and Time',
                fontSize: 16..sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250.h,
                        child: CupertinoDatePicker(
                          backgroundColor: AppColor.white,
                          initialDateTime: dateTime,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() {
                              dateTime = newTime;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50..h,
                  padding: EdgeInsets.symmetric(horizontal: 30),
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
                  child: Row(
                    children: [
                      SvgPicture.asset('${iconPath}calendar.svg'),
                      SizedBox(width: 20..w),
                      Text16(
                        text: dateTime== null
                            ? 'Choose Date and Time' : '${DateFormat('MM/dd/yyyy').format(dateTime!)}',
                        fontSize: 14..sp,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                text: 'Enter Detailed Description',
                fontSize: 16..sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200..h,
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
                child: TextField(
                  maxLines: null,
                  cursorColor: Color(0xFF9FA3A8),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(11),
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(
                      fontSize: 14..sp,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 70..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, BookNowAddress());
                },
                child: Button(
                  text: 'Next',
                ),
              ),
            ),
            SizedBox(height: 20..h),
          ],
        ),
      ),
    );
  }
}
