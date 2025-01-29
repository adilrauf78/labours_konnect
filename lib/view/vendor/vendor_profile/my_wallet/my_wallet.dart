import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_wallet/withdraw_money/withdraw_money.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
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
                          text: 'My Wallet',
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 20..w),
                      ],
                    ),
                    SizedBox(height: 30..h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text18(
                          text: 'Earnings',
                        ),
                        GestureDetector(
                          onTap: (){
                            navigateToNextScreen(context, WithdrawMoney());
                          },
                          child: Text16(
                            text: 'Withdraw',
                            color: AppColor.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15..h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Column(
                        children: [
                          MainText(
                            text: '\$ 100.00',
                            color: AppColor.white,
                          ),
                          Text16(
                            text: 'Available for withdrawal',
                            color: AppColor.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20..h),
                    Text18(
                      text: 'This Month Report',
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10..h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*.43,
                          padding: EdgeInsets.symmetric(vertical: 5),
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
                              SubText(
                                text: 'Total Earning',
                              ),
                              SizedBox(height: 5..h),
                              SubText(
                                text: 'TND 200',
                                color: AppColor.black,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*.43,
                          padding: EdgeInsets.symmetric(vertical: 5),
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
                              SubText(
                                text: 'Total Withdraw',
                              ),
                              SizedBox(height: 5..h),
                              SubText(
                                text: 'TND 100',
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20..h),
              TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColor.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                indicatorColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.black.withOpacity(.5),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black.withOpacity(.5),
                ),
                tabs: [
                  Tab(
                    text: 'All Transactions',
                  ),
                  Tab(
                    text: 'Request for Withdraw',
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
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColor.k0xFFEEEEEE,
                                      borderRadius: BorderRadius.circular(10..r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32..w,
                                              height: 32..h,
                                              decoration: BoxDecoration(
                                                color: AppColor.bgred,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset('${iconPath}up.svg')
                                              ),
                                            ),
                                            SizedBox(width: 20..w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MainText(
                                                  text: 'Debit',
                                                  fontSize: 16..sp,
                                                ),
                                                SubText(
                                                  text: 'Withdraw',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                SubText(
                                                  text: '9/11/2023',
                                                ),
                                                SizedBox(width: 5..w),
                                                SubText(
                                                  text: '01:30 pm',
                                                ),
                                              ],
                                            ),
                                            SubText(
                                              text: '\$250.00',
                                              color: AppColor.red,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColor.k0xFFEEEEEE,
                                      borderRadius: BorderRadius.circular(10..r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32..w,
                                              height: 32..h,
                                              decoration: BoxDecoration(
                                                color: AppColor.bggreen,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset('${iconPath}down.svg')
                                              ),
                                            ),
                                            SizedBox(width: 20..w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MainText(
                                                  text: 'Credit',
                                                  fontSize: 16..sp,
                                                ),
                                                SubText(
                                                  text: 'Booking # 251',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                SubText(
                                                  text: '9/11/2023',
                                                ),
                                                SizedBox(width: 5..w),
                                                SubText(
                                                  text: '01:30 pm',
                                                ),
                                              ],
                                            ),
                                            SubText(
                                              text: '\$250.00',
                                              color: AppColor.green,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColor.k0xFFEEEEEE,
                                      borderRadius: BorderRadius.circular(10..r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32..w,
                                              height: 32..h,
                                              decoration: BoxDecoration(
                                                color: AppColor.bgred,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset('${iconPath}up.svg')
                                              ),
                                            ),
                                            SizedBox(width: 20..w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MainText(
                                                  text: 'Debit',
                                                  fontSize: 16..sp,
                                                ),
                                                SubText(
                                                  text: 'Withdraw',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                SubText(
                                                  text: '9/11/2023',
                                                ),
                                                SizedBox(width: 5..w),
                                                SubText(
                                                  text: '01:30 pm',
                                                ),
                                              ],
                                            ),
                                            SubText(
                                              text: '\$250.00',
                                              color: AppColor.red,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColor.k0xFFEEEEEE,
                                      borderRadius: BorderRadius.circular(10..r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 32..w,
                                              height: 32..h,
                                              decoration: BoxDecoration(
                                                color: AppColor.bggreen,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset('${iconPath}down.svg')
                                              ),
                                            ),
                                            SizedBox(width: 20..w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                MainText(
                                                  text: 'Credit',
                                                  fontSize: 16..sp,
                                                ),
                                                SubText(
                                                  text: 'Booking # 251',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                SubText(
                                                  text: '9/11/2023',
                                                ),
                                                SizedBox(width: 5..w),
                                                SubText(
                                                  text: '01:30 pm',
                                                ),
                                              ],
                                            ),
                                            SubText(
                                              text: '\$250.00',
                                              color: AppColor.green,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
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
