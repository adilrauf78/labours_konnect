import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainText(
                    text: 'Bookings',
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: 30..h),
              TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColor.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                indicatorColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.black,
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'On Going',
                  ),
                  Tab(
                    text: 'History',
                  ),
                ],
              ),
              SizedBox(height: 20..h,),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 95..w,
                                                height: 30..h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.bgred,
                                                  borderRadius: BorderRadius.circular(5..r),
                                                ),
                                                child: Center(
                                                  child: Text15(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.red,
                                                    text: 'Pending',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5..h),
                                              Text16(
                                                text: 'Pipe Fitting',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Text16(
                                                text: '\$ 120.00',
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 93..w,
                                            height: 84..h,
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
                                      SizedBox(height: 20..h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Date & Time:',
                                            fontSize: 14..sp,
                                          ),
                                          Row(
                                            children: [
                                              Text16(
                                                text: '17 Nov 2023',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              ),
                                              SizedBox(width: 10..w),
                                              Text16(
                                                text: '03:30 pm',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: AppColor.black.withOpacity(.25),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Provider:',
                                            fontSize: 14..sp,
                                          ),
                                          Text16(
                                            text: 'Jack Marston',
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.black,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10..h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 95..w,
                                                height: 30..h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.bgblue,
                                                  borderRadius: BorderRadius.circular(5..r),
                                                ),
                                                child: Center(
                                                  child: Text15(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.blue,
                                                    text: 'Accepted',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5..h),
                                              Text16(
                                                text: 'Pipe Fitting',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Text16(
                                                text: '\$ 120.00',
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 93..w,
                                            height: 84..h,
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
                                      SizedBox(height: 20..h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Date & Time:',
                                            fontSize: 14..sp,
                                          ),
                                          Row(
                                            children: [
                                              Text16(
                                                text: '17 Nov 2023',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              ),
                                              SizedBox(width: 10..w),
                                              Text16(
                                                text: '03:30 pm',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: AppColor.black.withOpacity(.25),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Provider:',
                                            fontSize: 14..sp,
                                          ),
                                          Text16(
                                            text: 'Jack Marston',
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.black,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10..h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 95..w,
                                                height: 30..h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.bggreen,
                                                  borderRadius: BorderRadius.circular(5..r),
                                                ),
                                                child: Center(
                                                  child: Text15(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.green,
                                                    text: 'Pending',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5..h),
                                              Text16(
                                                text: 'Pipe Fitting',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Text16(
                                                text: '\$ 120.00',
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 93..w,
                                            height: 84..h,
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
                                      SizedBox(height: 20..h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Date & Time:',
                                            fontSize: 14..sp,
                                          ),
                                          Row(
                                            children: [
                                              Text16(
                                                text: '17 Nov 2023',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              ),
                                              SizedBox(width: 10..w),
                                              Text16(
                                                text: '03:30 pm',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: AppColor.black.withOpacity(.25),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Provider:',
                                            fontSize: 14..sp,
                                          ),
                                          Text16(
                                            text: 'Jack Marston',
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.black,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10..h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 95..w,
                                                height: 30..h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.bggreen,
                                                  borderRadius: BorderRadius.circular(5..r),
                                                ),
                                                child: Center(
                                                  child: Text15(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.green,
                                                    text: 'Pending',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5..h),
                                              Text16(
                                                text: 'Pipe Fitting',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Text16(
                                                text: '\$ 120.00',
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 93..w,
                                            height: 84..h,
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
                                      SizedBox(height: 20..h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Date & Time:',
                                            fontSize: 14..sp,
                                          ),
                                          Row(
                                            children: [
                                              Text16(
                                                text: '17 Nov 2023',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              ),
                                              SizedBox(width: 10..w),
                                              Text16(
                                                text: '03:30 pm',
                                                fontSize: 12..sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.black,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: AppColor.black.withOpacity(.25),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text16(
                                            text: 'Provider:',
                                            fontSize: 14..sp,
                                          ),
                                          Text16(
                                            text: 'Jack Marston',
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.black,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10..h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
