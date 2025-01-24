import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class RateServices extends StatefulWidget {
  const RateServices({super.key});

  @override
  State<RateServices> createState() => _RateServicesState();
}

class _RateServicesState extends State<RateServices> {
  double _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40..r),
            topLeft: Radius.circular(40..r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainText(
                text: 'Rate this Service?',
              ),
              SizedBox(height: 5..h),
              RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 35,
                  itemPadding: EdgeInsets.only(right: 10),
                  direction: Axis.horizontal,
                  unratedColor: Colors.black.withOpacity(.25),
                  itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                  onRatingUpdate: (rating1){
                    setState(() {
                      _rating = _rating;
                    });
                  }
              ),
              SizedBox(height: 25..h),
              Text15(
                text: 'Please share your opinion \n'
                  'about this service',
                color: AppColor.black.withOpacity(.7),
              ),
              SizedBox(height: 20..h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150..h,
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
                    hintText: 'Write a review',
                    hintStyle: TextStyle(
                      fontSize: 14..sp,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 25..h),
              GestureDetector(
                onTap: (){
                  navigateBackWithAnimation(context);
                },
                child: Button(
                  text: 'Done',
                ),
              )
            ],
          ),
        )
    );
  }
}
