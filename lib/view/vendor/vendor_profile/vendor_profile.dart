import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/account_screen/edit_profile/edit_profile.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';
import 'package:labours_konnect/view/vendor/add_services/add_services.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_review/my_review.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_services/my_services.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_wallet/my_wallet.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({super.key});

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  bool  customer = false;
  void _showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16..r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(16..r),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('${iconPath}close.svg',
                        height: 15..h,
                        width: 15..w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5..h),
                SvgPicture.asset('${iconPath}trash.svg'),
                SizedBox(height: 5..h),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text15(
                      text: 'Are you sure you want to delete this account?',
                      color: AppColor.black,
                      fontWeight: FontWeight.w400,
                    )
                ),
                SizedBox(height: 25..h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
                          height: 32..h,
                          width: 90..w,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Center(
                            child: Text('Yes',
                              style: TextStyle(
                                  fontSize: 16..sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 32..h,
                          width: 90..w,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.black.withOpacity(.25),
                                    blurRadius: 4
                                )
                              ]

                          ),
                          child: Center(
                            child: Text('No',
                              style: TextStyle(
                                  fontSize: 16..sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350..h,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 230..h,
                        padding: EdgeInsets.only(left: 20,right: 20,top: 55),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateBackWithAnimation(context);
                              },
                              child: Icon(Icons.arrow_back_ios,
                                color: AppColor.white,
                                size: 18,
                              ),
                            ),
                            MainText(
                              text: 'Profile',
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                            GestureDetector(
                              onTap: (){
                                navigateToNextScreen(context, AddServices());
                              },
                              child: Icon(Icons.edit_outlined,
                                color: AppColor.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 30,
                  top: 120,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 35..h),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
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
                                SizedBox(height: 30..h),
                                MainText(
                                  text: 'Jaylon Herwitz',
                                ),
                                SizedBox(height: 5..h),
                                Divider(
                                  color: AppColor.black.withOpacity(.1),
                                ),
                                SizedBox(height: 10..h,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text16(
                                            text: '120',
                                            color: AppColor.black.withOpacity(.7),
                                            fontSize: 18..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Text16(
                                            text: 'Total Jobs',
                                            color: AppColor.black.withOpacity(.3),
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text16(
                                            text: '1.5',
                                            color: AppColor.black.withOpacity(.7),
                                            fontSize: 18..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Text16(
                                            text: 'Years',
                                            color: AppColor.black.withOpacity(.3),
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70..w,
                              height: 70..h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                                image: DecorationImage(
                                  image: AssetImage('${imagePath}pipe.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, EditProfile());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'Edit Profile',
                          ),
                          SvgPicture.asset('${iconPath}arrow_left.svg'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15..h),
                  GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, MyServices());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'My Services',
                          ),
                          SvgPicture.asset('${iconPath}arrow_left.svg'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15..h),
                  GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, MyReview());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'My Reviews',
                          ),
                          SvgPicture.asset('${iconPath}arrow_left.svg'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15..h),
                  GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, MyWallet());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'My Wallet',
                          ),
                          SvgPicture.asset('${iconPath}arrow_left.svg'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15..h),
                  GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, BottomNavigator());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45..h,
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'Switch to Customer',
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                                activeColor: AppColor.primaryColor,
                                value: customer,
                                onChanged: (value){
                                  setState(() {
                                    customer =value;
                                  });
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25..h),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _showCustomPopup(context);
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset('${iconPath}delete.svg'),
                          SizedBox(width: 15..w,),
                          Text16(
                            text: 'Delete Account',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFD8333E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25..h),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('${iconPath}logout.svg'),
                        SizedBox(width: 15..w,),
                        MainText(
                          text: 'Logout',
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25..h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
