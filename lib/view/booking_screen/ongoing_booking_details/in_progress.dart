import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/booking_screen/ongoing_booking_details/bottomsheet_complete_booking/bottomsheet_complete_booking.dart';

class InProgress extends StatefulWidget {
  const InProgress({super.key});

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: CompleteBooking(),
        );
      },
    );
  }
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
                text: 'Pipe Fitting',
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
                            text: '17 Nov 2023',
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
                            text: '03:30 pm',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 5..h),
                      Text16(
                        text: '\$ 120.00',
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 15..h),
                      Container(
                        width: 95..w,
                        height: 30..h,
                        decoration: BoxDecoration(
                          color: AppColor.bgorange,
                          borderRadius: BorderRadius.circular(5..r),
                        ),
                        child: Center(
                          child: Text15(
                            fontWeight: FontWeight.w500,
                            color: AppColor.orange,
                            text: 'In Progress',
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
                        image: AssetImage('${imagePath}pipe.png'),
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
              Text16(
                text: 'Address',
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 5..h),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text16(
                  text: 'H#28 saleem Street # 17 Fiji garhi stop'
                      'Band Rd, Shera Kot, Lahore, Punjab 54000 '
                      'Pakistan',
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
              SizedBox(height: 20..h),
              Divider(
                color: AppColor.black.withOpacity(.25),
              ),
              SizedBox(height: 15..h),
              Text16(
                text: 'About Provider',
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
                                image: AssetImage('${imagePath}pipe.png'),
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
                                text: 'Jack Marston',
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
              SizedBox(height: 30..h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showBottomSheet(context);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50..h,
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    borderRadius: BorderRadius.circular(10..r),
                  ),
                  child: Center(
                    child: Text16(
                      text: 'Done',
                      color: AppColor.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20..h),
              GestureDetector(
                onTap: (){
                  navigateBackWithAnimation(context);
                },
                child: Button(
                  text: 'Cancel & Refund',
                ),
              ),
              SizedBox(height: 40..h),
            ],
          ),
        ),
      ),
    );
  }
}
