import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 55..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      navigateBackWithAnimation(context);
                    },
                    child: Icon(Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  MainText(
                    text: 'Payment',
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    width: 20..w,
                  )
                ],
              ),
              SizedBox(height: 30..h,),
              Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10..r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('${iconPath}chip.svg'),
                      ],
                    ),
                    SizedBox(height: 20..h),
                    Text24(
                      text: '* * * *  * * * *  * * * *',
                      color: AppColor.white,
                    ),
                    Text24(
                      text: '3246',
                      color: AppColor.white,
                    ),
                    SizedBox(height: 25..h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text12(
                              text: 'Card Holder Name',
                              fontSize: 10..sp,
                              color: AppColor.white.withOpacity(.5),
                            ),
                            Text12(
                              text: 'Jennyfer Doe',
                              fontSize: 10..sp,
                              color: AppColor.white,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text12(
                              text: 'Expiry Date',
                              fontSize: 10..sp,
                              color: AppColor.white.withOpacity(.5),
                            ),
                            Text12(
                              text: '05/23',
                              fontSize: 10..sp,
                              color: AppColor.white,
                            )
                          ],
                        ),
                        Image.asset('${imagePath}mastercard_logo.png'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20..h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,),
                height: 50..h,
                width: MediaQuery.of(context).size.width,
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
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name on card',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black.withOpacity(.5),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10..h,),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,top: 15),
                    height: 60..h,
                    width: MediaQuery.of(context).size.width,
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '5546 8205 3693 3947',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:  5,
                    left: 15,
                    child: Text15(
                      text: 'Card Number',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10..h,),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,top: 15),
                    height: 60..h,
                    width: MediaQuery.of(context).size.width,
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '05/23',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:  5,
                    left: 15,
                    child: Text15(
                      text: 'Expire Date',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10..h,),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,top: 15),
                    height: 60..h,
                    width: MediaQuery.of(context).size.width,
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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '554',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top:  5,
                    left: 15,
                    child: Text15(
                      text: 'CVV',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 110..h,),
              GestureDetector(
                  onTap: (){

                  },
                  child: Button(
                      text: 'Add Card'),
              ),
              SizedBox(height: 25..h),
            ],
          ),
        ),
      ),
    );
  }
}
