import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';
import 'package:labours_konnect/view/auth_screens/verify_account/verify_account.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_authController) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55
                  ..h,),
                GestureDetector(
                  onTap: () {
                    navigateBackWithAnimation(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColor.black,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30
                  ..h,),
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
                SizedBox(height: 30
                  ..h,),
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
                SizedBox(height: 20
                  ..h,),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .8,
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                                text: 'Create Account'
                            ),
                            SubText(
                                text: 'Enter your email for verification'),
                            SizedBox(height: 20
                              ..h,),
                            Text15(
                              text: 'Email',
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 10
                              ..h,),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 50
                                ..h,
                              child: TextField(
                                controller: _authController.emailController,
                                cursorColor: AppColor.black.withOpacity(.5),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10
                                          ..r),
                                        borderSide: BorderSide(
                                          color: Color(0xFFEEEEEE),
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10
                                          ..r),
                                        borderSide: BorderSide(
                                          color: Color(0xFFEEEEEE),
                                        )
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    fillColor: AppColor.white,
                                    filled: true,
                                    prefixIcon: Transform.scale(
                                      scale: 0.45,
                                      child: SvgPicture.asset(
                                          '${iconPath}email.svg'),
                                    ),
                                    hintText: 'dummy@email.com',
                                    hintStyle: TextStyle(
                                      color: AppColor.black.withOpacity(.3),
                                      fontSize: 15
                                        ..sp,
                                      fontWeight: FontWeight.w400,
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 50
                              ..h,),
                            _authController.isLoading
                                ? SpinKitRing(
                              color: AppColor.blue,
                              size:40,
                              lineWidth: 4,
                            ) : GestureDetector(
                                onTap: () {
                                  _authController.EmailController();
                                  //navigateToNextScreen(context, VerifyAccount());
                                },
                                child: Button(text: 'Verify')),
                            SizedBox(height: 235
                              ..h,),
                            GestureDetector(
                              onTap: () {
                                navigateToNextScreen(context, SignInScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text15(
                                    text: 'Already have an account?',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Text15(text: 'Sign In',
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
                                text: 'Create Account'
                            ),
                            SubText(
                                text: 'Enter your Phone number for verification'),
                            SizedBox(height: 20
                              ..h,),
                            Text15(
                              text: 'Phone',
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 10
                              ..h,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 50
                                ..h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10
                                    ..r),
                                  color: AppColor.white,
                                  border: Border.all(
                                    color: Color(0xFFEEEEEE),
                                  )
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .25,
                                    child: CountryCodePicker(
                                      // flagWidth: 90,
                                      padding: const EdgeInsets.all(0),
                                      textStyle: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 14
                                          ..sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      initialSelection: "KF",
                                    ),
                                  ),
                                  SizedBox(width: 5
                                    ..w),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7.0),
                                    child: VerticalDivider(
                                      color: Color(0xFF666666),
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(width: 5
                                    ..w),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .55,
                                    child: TextField(
                                      cursorColor: AppColor.black.withOpacity(
                                          .5),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '000 000 000',
                                          hintStyle: TextStyle(
                                            color: AppColor.black.withOpacity(
                                                .3),
                                            fontSize: 15
                                              ..sp,
                                            fontWeight: FontWeight.w400,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50
                              ..h,),
                            GestureDetector(
                              onTap: () {
                                navigateToNextScreen(context, VerifyAccount());
                              },
                              child: Button(
                                text: 'Verify',
                              ),
                            ),
                            SizedBox(height: 235
                              ..h,),
                            GestureDetector(
                              onTap: () {
                                navigateToNextScreen(context, SignInScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text15(
                                    text: 'Already have an account?',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Text15(text: 'Sign In',
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
                SizedBox(height: 20
                  ..h,),
              ],
            ),
          ),
        ),
      );
    });
  }
}
