import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35..w,
                        height: 35..h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50..r),
                          child: Image.asset('${imagePath}image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20..w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubText(
                            text: 'Location',
                            fontSize: 12..sp,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text12(
                                  text: 'Barbican, Jamaica',
                                  fontSize: 14..sp,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 35..w,
                    height: 35..h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.k0xFF818080,
                      ),
                    ),
                    child: Center(
                        child: SvgPicture.asset('${iconPath}bell.svg')
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                  ),
                  SizedBox(width: 10..w),
                  Container(
                    width: 45..w,
                    height: 45..h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10..r),
                      border: Border.all(
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                    child: Center(
                        child: SvgPicture.asset('${iconPath}filter.svg'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
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
                        MainText(
                          text: 'Categories',
                          fontSize: 18..sp,
                          fontWeight: FontWeight.w500,
                        ),
                        Text(
                          'More',
                          style: TextStyle(
                            color: AppColor.red,
                            fontSize: 14..sp,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.red,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10..h),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: (1 / 1.59),
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: List.generate(8, (index) {
                        return Container(
                          child: Column(
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
                              SizedBox(height: 5..h),
                              Text15(
                                text: 'House Painting',
                                fontSize: 12..sp,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10..h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: MainText(
                text: 'Near to your address',
                fontSize: 16..sp,
              ),
            ),
            SizedBox(height: 20..h),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 210..w,
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
                          Container(
                            width: 210..w,
                            height: 250..h,
                            padding: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              image: DecorationImage(
                                image: AssetImage('${imagePath}man.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
