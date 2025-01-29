import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key});

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
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
                    text: 'My Review',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
              SizedBox(height: 30..h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: MainText(
                      text: '$_rating',
                    ),
                  ),
                  Center(
                    child: RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        itemCount: 5,
                        itemSize: 22,
                        itemPadding: EdgeInsets.only(right: 5),
                        direction: Axis.horizontal,
                        unratedColor: Color(0x4DF9E005),
                        itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                        onRatingUpdate: (rating1){
                          setState(() {
                            _rating = _rating;
                          });
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10..h),
              Row(
                children: [
                  Text18(
                    text: 'Reviews ',
                    fontWeight: FontWeight.w700,
                  ),
                  Text18(
                    text: '(64)',
                    fontWeight: FontWeight.w700,
                    color: AppColor.black.withOpacity(.25),
                  ),
                ],
              ),
              Divider(
                color: AppColor.black.withOpacity(.1),
              ),
              SizedBox(height: 10..h,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5..h),
                                  Text16(
                                    text: 'Pipe Fitting',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20..sp,
                                  ),
                                  SizedBox(height: 15..h),
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
                                ],
                              ),
                              Container(
                                width: 96..w,
                                height: 87..h,
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
                          SizedBox(height: 5..h),
                          Divider(
                            color: AppColor.black.withOpacity(.1),
                          ),
                          SizedBox(height: 5..h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30..w,
                                    height: 30..h,
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
                                    children: [
                                      MainText(
                                        text: 'Jack Marston',
                                        fontSize: 12..sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Text(
                                        'Nov 15, 2021',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 8..sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      itemCount: 5,
                                      itemSize: 12,
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
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15..h),
                          SubText(
                            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                                'incididunt utertid labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '
                                'exercitation ullamco aruun laboris nisi ut aliquip ex ea commodo consequat.',
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20..h),
            ],
          ),
        ),
      ),
    );
  }
}
