import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                  text: 'Categories',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 20..h),
            Container(
              height: 45..h,
              child: TextField(
                cursorColor: AppColor.black.withOpacity(.5),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10..r),
                      borderSide: BorderSide(
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10..r),
                        borderSide: BorderSide(
                          color: Color(0xFFEEEEEE),
                        )
                    ),
                    contentPadding: EdgeInsets.zero,
                    fillColor: AppColor.white,
                    filled: true,
                    prefixIcon: Transform.scale(
                      scale: 0.45,
                      child: SvgPicture.asset('${iconPath}search.svg'),
                    ),
                    hintText: 'Search here ',
                    hintStyle: TextStyle(
                      color: AppColor.black.withOpacity(.3),
                      fontSize: 15..sp,
                      fontWeight: FontWeight.w400,
                    )
                ),
              ),
            ),
            SizedBox(height: 20..h),
            ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                        bottom: BorderSide(
                          color: AppColor.black.withOpacity(.1),
                        )
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60..w,
                        height: 60..h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withOpacity(.25),
                                blurRadius: 2
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset('${iconPath}paint-roller.svg'),
                        ),
                      ),
                      SizedBox(width: 20..w),
                      SubText(
                        text: 'Cleaning Services',
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
