import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/details/details.dart';
import 'package:labours_konnect/view/home_screen/filter/filter.dart';

class CategoryOpen extends StatefulWidget {
  const CategoryOpen({super.key});

  @override
  State<CategoryOpen> createState() => _CategoryOpenState();
}

class _CategoryOpenState extends State<CategoryOpen> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: Filter(),
        );
      },
    );
  }
  bool favorite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                    text: 'Cleaning',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Row(
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showBottomSheet(context);
                    });
                  },
                  child: Container(
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
                  ),
                )
              ],
            ),
            SizedBox(height: 30..h),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, Details());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFBFBFB),
                        borderRadius: BorderRadius.circular(10..r),
                        border: Border.all(
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 130..w,
                                height: 160..h,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  image: DecorationImage(
                                    image: AssetImage('${imagePath}painter.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(5..r),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      favorite = !favorite;
                                    });
                                  },
                                  child: Container(
                                    width: 25..w,
                                    height: 25..h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.k0xFFEEEEEE,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: favorite ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 18,) :
                                        Icon(Icons.favorite,color: AppColor.red,size: 18,)
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Container(
                                  width: 85..w,
                                  height: 20..h,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(5..r),
                                  ),
                                  child: Center(
                                    child: Text18(
                                      text: 'Level two',
                                      color: AppColor.white,
                                      fontSize: 12..sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10..w),
                          Expanded(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2..h),
                                    MainText(
                                      text: 'Jack Marston',
                                    ),
                                    SubText(
                                      text: 'Painter',
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
                                    Row(
                                      children: [
                                        SvgPicture.asset('${iconPath}map-pin.svg'),
                                        SizedBox(width: 10..w),
                                        Text12(
                                          text: 'Woodstock, GA',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25..h),
                                Container(
                                  height: 40..h,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10..r),
                                  ),
                                  child: Center(
                                    child: Text16(
                                      text: 'Book Now',
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
