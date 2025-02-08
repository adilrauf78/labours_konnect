import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/view/account_screen/account_screen.dart';
import 'package:labours_konnect/view/booking_screen/booking_screen.dart';
import 'package:labours_konnect/view/home_screen/home_screen.dart';
import 'package:labours_konnect/view/message_screen/message_screen.dart';
import 'package:labours_konnect/view/my_location/my_location.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_home.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_services/my_services.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/vendor_profile.dart';

class VendorBottomNavigator extends StatefulWidget {
  const VendorBottomNavigator({super.key});

  @override
  State<VendorBottomNavigator> createState() => _VendorBottomNavigator();
}

class _VendorBottomNavigator extends State<VendorBottomNavigator> {
  int currentTab = 0;
  List _pages = [
    VendorHome(),
    MyServices(),
    MessageScreen(),
    VendorProfile(),

  ];
  _changeTab(int index) {
    setState(() {
      currentTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyLocation()));
        },
        child: SvgPicture.asset('${iconPath}my_location.svg'),
        elevation: 5,
        backgroundColor: AppColor.white,
        shape: CircleBorder(
            side: BorderSide(
              color: Color(0x40000000),
            )
        ),
      ),

      bottomNavigationBar:
      BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        color: AppColor.primaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12..r),
              topRight: Radius.circular(12..r),
            ),
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                  child: Container(
                    width: 50..w,
                    height: 50..h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(currentTab == 0 ?"${iconPath}homeclick.svg" :"${iconPath}home.svg",),
                        SizedBox(height: 8..h),
                        Text(
                          ('Home'),
                          style: TextStyle(
                              color: currentTab == 0 ? AppColor.white : AppColor.white.withOpacity(.8),
                              fontSize: 10..sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTab = 1;
                    });
                  },
                  child: Container(
                    width: 50..w,
                    height: 50..h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(currentTab == 1 ?"${iconPath}bookingclick.svg" : "${iconPath}booking.svg",),
                        SizedBox(height: 8..h),
                        Text(
                          ('Booking'),
                          style: TextStyle(
                              color: currentTab == 1 ? AppColor.white : AppColor.white.withOpacity(.8),
                              fontSize: 10..sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 12..sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTab = 2;
                    });
                  },
                  child: Container(
                    width: 50..w,
                    height: 50..h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(currentTab == 2 ?"${iconPath}messageclick.svg" :"${iconPath}message.svg",),
                        SizedBox(height: 8..h),
                        Text(
                          'Message',
                          style: TextStyle(
                              color: currentTab == 2 ? AppColor.white : AppColor.white.withOpacity(.8),
                              fontSize: 10..sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:  () {
                    setState(() {
                      currentTab = 3;
                    });
                  },
                  child: Container(
                    width: 50..w,
                    height: 50..h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(currentTab == 3 ?"${iconPath}accountclick.svg" : "${iconPath}account.svg",),
                        SizedBox(height: 8..h),
                        Text(
                          'Account',
                          style: TextStyle(
                              color: currentTab == 3 ? AppColor.white : AppColor.white.withOpacity(.8),
                              fontSize: 10..sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _pages[currentTab],

    );;
  }
}