import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/book_now_controller/book_now_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';

import '../../../../custom_widgets/custom_button/custom_button.dart';

class VendorBookingPending extends StatefulWidget {
  final BookNowModel booking;
  const VendorBookingPending({super.key, required this.booking});

  @override
  State<VendorBookingPending> createState() => _VendorBookingPendingState();
}

class _VendorBookingPendingState extends State<VendorBookingPending> {
  final BookNowController bookNowController = Get.put(BookNowController());
  double _rating = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h),
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
                    text: 'Bookings Details',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
              SizedBox(height: 30..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text16(
                    text: 'Booking ID',
                    fontSize: 15..sp,
                    fontWeight: FontWeight.w400,
                  ),
                  Text16(
                    text: '#258',
                    fontSize: 15..sp,
                    color: AppColor.red,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Divider(
                color: AppColor.black.withOpacity(.25),
              ),
              Text16(
                text: widget.booking.serviceName,
                fontWeight: FontWeight.w700,
                fontSize: 20..sp,
              ),
              SizedBox(height: 10..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text16(
                            text: 'Date: ',
                            fontSize: 14..sp,
                          ),
                          SizedBox(width: 10..w),
                          Text16(
                            text: DateFormat('d MMMM y').format(widget.booking.bookingDate),
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text16(
                            text: 'Time: ',
                            fontSize: 14..sp,
                          ),
                          SizedBox(width: 10..w),
                          Text16(
                            text: widget.booking.bookingTime,
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 5..h),
                      Text16(
                        text: '\$${widget.booking.price}',
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15..h),
                      Container(
                        width: 95..w,
                        height: 30..h,
                        decoration: BoxDecoration(
                          color: widget.booking.status == 'Accepted'
                              ? AppColor.bgblue
                              : widget.booking.status == 'On Going'
                              ? AppColor.bggreen
                              : widget.booking.status == 'In Progress'
                              ? AppColor.bgorange
                              : widget.booking.status == 'Completed'
                              ? AppColor.primaryColor
                              : AppColor.bgred,
                          borderRadius: BorderRadius.circular(5..r),
                        ),
                        child: Center(
                          child: Text15(
                            fontWeight: FontWeight.w500,
                            color: widget.booking.status == 'Accepted'
                                ? AppColor.blue
                                : widget.booking.status == 'On Going'
                                ? AppColor.green
                                : widget.booking.status == 'In Progress'
                                ? AppColor.orange
                                : widget.booking.status == 'Completed'
                                ? AppColor.primaryColor
                                : AppColor.red,
                            text: widget.booking.status,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 133..w,
                    height: 120..h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10..r),
                      image: DecorationImage(
                        image: widget.booking.serviceImage.isNotEmpty
                            ? NetworkImage(widget.booking.serviceImage)
                            : AssetImage('${imagePath}pipe-fitting.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15..h),
              Divider(
                color: AppColor.black.withOpacity(.25),
              ),
              SizedBox(height: 15..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text16(
                    text: 'Address',
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(5..r),
                    ),
                    child: Center(
                      child: Text16(
                        text: 'Get Direction',
                        fontSize: 14..sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10..h),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text16(
                  text: widget.booking.location,
                  fontSize: 15..sp,
                ),
              ),
              SizedBox(height: 15..h),
              Divider(
                color: AppColor.black.withOpacity(.25),
              ),
              SizedBox(height: 15..h,),
              Text16(
                text: 'Price Detail',
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 15..h),
              Container(
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
                          text: '\$${widget.booking.price}',
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
                          text: '\$${widget.booking.price}',
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20..h),
              Divider(
                color: AppColor.black.withOpacity(.25),
              ),
              SizedBox(height: 15..h),
              Text16(
                text: 'About Customer',
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
              SizedBox(height: 15..h),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10..r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 78..w,
                            height: 78..h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                              image: DecorationImage(
                                image: widget.booking.serviceImage.isNotEmpty
                                    ? NetworkImage(widget.booking.userName)
                                    : AssetImage('${imagePath}pipe-fitting.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15..w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text16(
                                text: widget.booking.userName,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      itemCount: 5,
                                      itemSize: 15,
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
                                      color: AppColor.white,
                                      fontSize: 12..sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10..h),
                    Divider(
                      color: AppColor.white.withOpacity(.25),
                      thickness: 1,
                    ),
                    SizedBox(height: 5..h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.4,
                            height: 40..h,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10..r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.k0xFFEEEEEE,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('${iconPath}call.svg'),
                                SizedBox(width: 3..w),
                                Text16(
                                  text: 'Call',
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.4,
                            height: 40..h,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10..r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.k0xFFEEEEEE,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('${iconPath}messages.svg'),
                                SizedBox(width: 3..w),
                                Text16(
                                  text: 'Message',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.booking.status == 'Accepted')
              Column(
                children: [
                  SizedBox(height: 30..h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          bookNowController.OnGoingBooking(widget.booking.bookingId);
                          Get.back();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.4,
                          height: 50..h,
                          decoration: BoxDecoration(
                            color: Color(0xFF40C373),
                            borderRadius: BorderRadius.circular(10..r),
                          ),
                          child: Center(
                            child: Text16(
                              text: 'On Going',
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          bookNowController.cancelBooking(widget.booking.bookingId);
                          Get.back();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*.4,
                          height: 50..h,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10..r),
                          ),
                          child: Center(
                            child: Text16(
                              text: 'Cancel',
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              if (widget.booking.status == 'On Going')
              Column(
                children: [
                  SizedBox(height: 30..h),
                  GestureDetector(
                    onTap: (){
                      bookNowController.InProgressBooking(widget.booking.bookingId);
                      Get.back();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50..h,
                      decoration: BoxDecoration(
                        color: Color(0xFF40C373),
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Center(
                        child: Text16(
                          text: 'Start',
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.booking.status == 'In Progress')
                Column(
                  children: [
                    SizedBox(height: 30..h),
                    GestureDetector(
                      onTap: (){
                        bookNowController.markBookingAsCompleted(widget.booking.bookingId);
                        Get.back();
                      },
                      child: Button(
                        text: 'In Progress',
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 30..h),
            ],
          ),
        ),
      ),
    );
  }
}
