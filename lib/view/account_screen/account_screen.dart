import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    text: 'Account',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
              SizedBox(height: 20..h),
              Row(
                children: [
                  Container(
                    width: 100..w,
                    height: 100..h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.primaryColor, width: 2), // Black border
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50..r), // Circular border radius
                      child: Image.asset('${imagePath}image.png',
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20..w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Jaydon Siphron',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 5..h),
                      Text12(
                        text: '(+1) 331 623 8413',
                      ),
                      SizedBox(height: 5..h),
                      Row(
                        children: [
                          Icon(Icons.email_outlined,size: 20,color: AppColor.black.withOpacity(.5),),
                          SizedBox(width: 5..h,),
                          Text12(
                            text: 'alexandra23@gmail.com',
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 30..h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45..h,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10..r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text15(
                      text: 'Edit Profile',
                    ),
                    SvgPicture.asset('${iconPath}arrow_left.svg'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
