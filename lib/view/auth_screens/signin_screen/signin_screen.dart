import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/create_account/create_account.dart';
import 'package:labours_konnect/view/auth_screens/forget_password/forgetPassword_bottomSheet.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: ForgetPassword(),
        );
      },
    );
  }

  bool hidden = true;
  bool hidden1 = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h,),
              SizedBox(height: 48..h,),
              Center(
                child: Text(
                  'Logo',
                  style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                ),
              ),
              ),
              SizedBox(height: 30..h,),
              TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.tab,
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
                    text: 'Email',
                  ),
                  Tab(
                    text: 'Phone',
                  )
                ],
              ),
              SizedBox(height: 20..h,),
              SizedBox(
                height: MediaQuery.of(context).size.height * .67,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                              text: 'Sign In'
                          ),
                          SubText(
                              text: 'Enter your email and password to sign in'),
                          SizedBox(height: 20..h,),
                          Text15(
                            text: 'Email',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10..h,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50..h,
                            child: TextField(
                              cursorColor: AppColor.black.withOpacity(.5),
                              keyboardType: TextInputType.emailAddress,
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
                                  prefixIcon: Transform.scale(
                                    scale: 0.45,
                                    child: SvgPicture.asset('${iconPath}email.svg'),
                                  ),
                                  hintText: 'dummy@email.com',
                                  hintStyle: TextStyle(
                                    color: AppColor.black.withOpacity(.3),
                                    fontSize: 15..sp,
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 15..h,),
                          Text15(
                            text: 'Password',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10..h,),
                          SizedBox(
                            height: 50..h,
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              cursorColor: AppColor.black.withOpacity(.5),
                              obscureText: hidden,
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
                                prefixIcon: Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset('${iconPath}lock.svg'),
                                ),
                                hintStyle: TextStyle(
                                        fontSize: 15..sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.borderColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hidden = !hidden;
                                    });
                                  },
                                  child: Icon(
                                    hidden ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF9FA3A8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _showBottomSheet(context);
                                  });
                                },
                                child: Text15(
                                  text: 'Forgot password?',
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30..h,),
                          GestureDetector(
                              onTap: () {
                              },
                              child: Button(text: 'Sign In')),
                          SizedBox(height: 30..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1..h,
                                width: MediaQuery.of(context).size.width * .4,
                                color: AppColor.black.withOpacity(.25),
                              ),
                              MainText(
                                text: 'or',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              Container(
                                height: 1..h,
                                width: MediaQuery.of(context).size.width * .4,
                                color: AppColor.black.withOpacity(.25),
                              ),
                            ],
                          ),
                          SizedBox(height: 25..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                  },
                                  child: SvgPicture.asset('${iconPath}google.svg')
                              ),
                              SizedBox(width: 20..w,),
                              InkWell(
                                  onTap: () {
                                  },
                                  child: SvgPicture.asset('${iconPath}facebook.svg')
                              ),
                              SizedBox(width: 20..w,),
                              SvgPicture.asset('${iconPath}linkedin.svg'),
                            ],
                          ),
                          SizedBox(height: 25..h,),
                          InkWell(
                            onTap: () {
                              navigateToNextScreen(context, CreateAccount());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text15(
                                  text: 'Don’t have any account?',
                                  fontWeight: FontWeight.w400,
                                ),
                                Text15(text: 'Sign Up',
                                  color: AppColor.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                              text: 'Sign In'
                          ),
                          SubText(
                              text: 'Enter your Phone number and password to signIn'),
                          SizedBox(height: 20..h,),
                          Text15(
                            text: 'Phone',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10..h,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50..h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10..r),
                                color: AppColor.white,
                                border: Border.all(
                                  color: Color(0xFFEEEEEE),
                                )
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .25,
                                  child: CountryCodePicker(
                                    // flagWidth: 90,
                                    padding: const EdgeInsets.all(0),
                                    textStyle: TextStyle(
                                      color: Color(0xFF666666),
                                      fontSize: 14..sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    initialSelection: "KF",
                                  ),
                                ),
                                SizedBox(width: 5..w),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                                  child: VerticalDivider(
                                    color: Color(0xFF666666),
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(width: 5..w),
                                Container(
                                  width: MediaQuery.of(context).size.width * .55,
                                  child: TextField(
                                    cursorColor: AppColor.black.withOpacity(.5),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '000 000 000',
                                        hintStyle: TextStyle(
                                          color: AppColor.black.withOpacity(.3),
                                          fontSize: 15..sp,
                                          fontWeight: FontWeight.w400,
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15..h,),
                          Text15(
                            text: 'Password',
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10..h,),
                          SizedBox(
                            height: 50..h,
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              cursorColor: AppColor.black.withOpacity(.5),
                              obscureText: hidden1,
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
                                prefixIcon: Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset('${iconPath}lock.svg')),
                                hintStyle: TextStyle(
                                        fontSize: 15..sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.borderColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hidden1 = !hidden1;
                                    });
                                  },
                                  child: Icon(
                                    hidden1 ? Icons.visibility_off : Icons.visibility,
                                    color: Color(0xFF9FA3A8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _showBottomSheet(context);
                                  });
                                },
                                child: Text15(
                                  text: 'Forgot password?',
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30..h,),
                          GestureDetector(
                              onTap: () {
                              },
                              child: Button(
                                  text: 'Sign In'),
                          ),
                          SizedBox(height: 30..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1..h,
                                width: MediaQuery.of(context).size.width * .4,
                                color: AppColor.black.withOpacity(.25),
                              ),
                              MainText(
                                text: 'or',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              Container(
                                height: 1..h,
                                width: MediaQuery.of(context).size.width * .4,
                                color: AppColor.black.withOpacity(.25),
                              ),
                            ],
                          ),
                          SizedBox(height: 25..h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                  },
                                  child: SvgPicture.asset('${iconPath}google.svg')
                              ),
                              SizedBox(width: 20..w,),
                              InkWell(
                                  onTap: () {
                                  },
                                  child: SvgPicture.asset('${iconPath}facebook.svg')
                              ),
                              SizedBox(width: 20..w,),
                              SvgPicture.asset('${iconPath}linkedin.svg'),
                            ],
                          ),
                          SizedBox(height: 25..h,),
                          GestureDetector(
                            onTap: () {
                              navigateToNextScreen(context, CreateAccount());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text15(
                                  text: 'Don’t have any account?',
                                  fontWeight: FontWeight.w400,
                                ),
                                Text15(text: 'Sign Up',
                                  color: AppColor.primaryColor,
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
              SizedBox(height: 20..h,),
            ],
          ),
        ),
      ),
    );
  }
}
