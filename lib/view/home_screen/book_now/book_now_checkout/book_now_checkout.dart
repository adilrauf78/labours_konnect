import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/home_screen/book_now/book_now_checkout/bottomsheet_confirm_booking/bottomsheet_confirm_booking.dart';

class BookNowCheckout extends StatefulWidget {
  final AddServicesModel service;
  const BookNowCheckout({super.key, required this.service});

  @override
  State<BookNowCheckout> createState() => _BookNowCheckoutState();
}

class _BookNowCheckoutState extends State<BookNowCheckout> {
  double _rating = 5;
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: ConfirmBooking(),
        );
      },
    );
  }
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
                      color: AppColor.primaryColor,
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
                      color: AppColor.primaryColor,
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
            SizedBox(height: 25..h),
            SizedBox(height: 25..h),
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
                    ),
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
                              text: 'Pipe Fitting',
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
                                  text: '\$ 20.00',
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
            SizedBox(height: 15..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text16(
                          text: 'Date:',
                        ),
                        SizedBox(width: 10..w),
                        Text16(
                          text: '17 Nov 2023',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 10..h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text16(
                          text: 'Time:',
                        ),
                        SizedBox(width: 10..w),
                        Text16(
                          text: '03:30 pm',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                text: 'Price Detail',
                fontSize: 16..sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16(
                          text: 'Price',
                        ),
                        Text16(
                          text: '\$20.00',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColor.black.withOpacity(.25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16(
                          text: 'Subtotal',
                        ),
                        Text16(
                          text: '\$20.00',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColor.black.withOpacity(.25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16(
                          text: 'Tax',
                        ),
                        Text16(
                          text: '\$20.00',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColor.black.withOpacity(.25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16(
                          text: 'Total Amount',
                        ),
                        Text16(
                          text: '\$20.00',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30..h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showBottomSheet(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Button(
                  text: 'Confirm Booking',
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
