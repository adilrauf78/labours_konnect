import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/categories/categories.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int currentIndex = 0;
  String selectedCategory = 'Choose Category';
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 77..w,
                  height: 3..h,
                  decoration: BoxDecoration(
                    color: AppColor.k0xFFEEEEEE,
                    borderRadius: BorderRadius.circular(10..r),
                  ),
                ),
              ),
              SizedBox(height: 10..h),
              Center(
                child: MainText(
                  text: 'Filter',
                ),
              ),
              SizedBox(height: 30..h),
              MainText(
                text: 'Category',
                fontWeight: FontWeight.w500,
                fontSize: 18..sp,
              ),
              SizedBox(height: 10..h),
              GestureDetector(
                onTap: () async {
                  final selected = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Categories(isFromFilter: true),),);
                  if (selected != null) {
                    setState(() {
                      selectedCategory = selected;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45..h,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: Color(0xFFEEEEEE),
                    ),
                    borderRadius: BorderRadius.circular(10..r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(
                        text: selectedCategory,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined,)
                    ],
                  ),
                ),
              ),
              SizedBox(height:20..h),
              MainText(
                text: 'Location',
                fontWeight: FontWeight.w500,
                fontSize: 18..sp,
              ),
              SizedBox(height: 10..h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45..h,
                child: TextField(
                  cursorColor: AppColor.black.withOpacity(.5),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10..r),
                          borderSide: BorderSide(
                            color: Color(0xFFEEEEEE),
                          )
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
                      hintStyle: TextStyle(
                        color: AppColor.black.withOpacity(.3),
                        fontSize: 15..sp,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              SizedBox(height:20..h),
              MainText(
                text: 'Rating',
                fontWeight: FontWeight.w500,
                fontSize: 18..sp,
              ),
              SizedBox(height: 15..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20..r),
                        color: currentIndex == 1 ? AppColor.primaryColor : AppColor.k0xFFEEEEEE,
                      ),
                      child: Row(
                        children: [
                          MainText(
                            text: '1',
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 1 ? AppColor.white : AppColor.black,
                            fontSize: 16..sp,
                          ),
                          SizedBox(width: 3..w),
                          Icon(Icons.star,color: Color(0xFFFFD800),size: 20,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20..r),
                        color: currentIndex == 2 ? AppColor.primaryColor : AppColor.k0xFFEEEEEE,
                      ),
                      child: Row(
                        children: [
                          MainText(
                            text: '2',
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 2 ? AppColor.white : AppColor.black,
                            fontSize: 16..sp,
                          ),
                          SizedBox(width: 3..w),
                          Icon(Icons.star,color: Color(0xFFFFD800),size: 20,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20..r),
                        color: currentIndex == 3 ? AppColor.primaryColor : AppColor.k0xFFEEEEEE,
                      ),
                      child: Row(
                        children: [
                          MainText(
                            text: '3',
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 3 ? AppColor.white : AppColor.black,
                            fontSize: 16..sp,
                          ),
                          SizedBox(width: 3..w),
                          Icon(Icons.star,color: Color(0xFFFFD800),size: 20,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 4;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20..r),
                        color: currentIndex == 4 ? AppColor.primaryColor : AppColor.k0xFFEEEEEE,
                      ),
                      child: Row(
                        children: [
                          MainText(
                            text: '4',
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 4 ? AppColor.white : AppColor.black,
                            fontSize: 16..sp,
                          ),
                          SizedBox(width: 3..w),
                          Icon(Icons.star,color: Color(0xFFFFD800),size: 20,)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 5;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20..r),
                        color: currentIndex == 5 ? AppColor.primaryColor : AppColor.k0xFFEEEEEE,
                      ),
                      child: Row(
                        children: [
                          MainText(
                            text: '5',
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 5 ? AppColor.white : AppColor.black,
                            fontSize: 16..sp,
                          ),
                          SizedBox(width: 3..w),
                          Icon(Icons.star,color: Color(0xFFFFD800),size: 20,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60..h),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Button(
                  text: 'Submit',
                ),
              )
            ],
          ),
        )
    );
  }
}
