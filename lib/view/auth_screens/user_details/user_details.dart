import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/enable_location/enable_location.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool obscureText = true;
  bool obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h,),
              GestureDetector(
                onTap: () {
                  navigateBackWithAnimation(context);
                },
                child: Icon(Icons.arrow_back_ios,
                  color: AppColor.black,
                  size: 18..sp,
                ),
              ),
              SizedBox(height: 20..h,),
              MainText(
                  text: 'Lets Get Started',
              ),
              SubText(
                  text: 'Enter the following details to create account',
              ),
              SizedBox(height: 20..h,),
              Text15(
                text: 'First Name',
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10..h,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45..h,
                child: TextField(
                  cursorColor: AppColor.black.withOpacity(.5),
                  keyboardType: TextInputType.name,
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
                        child: SvgPicture.asset(
                            '${iconPath}person.svg'),
                      ),
                      hintStyle: TextStyle(
                        color: AppColor.black.withOpacity(.3),
                        fontSize: 15..sp,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              Text15(
                text: 'Last Name',
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10..h,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45..h,
                child: TextField(
                  cursorColor: AppColor.black.withOpacity(.5),
                  keyboardType: TextInputType.name,
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
                        child: SvgPicture.asset(
                            '${iconPath}person.svg'),
                      ),
                      hintStyle: TextStyle(
                        color: AppColor.black.withOpacity(.3),
                        fontSize: 15..sp,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              Text15(
                text: 'Password',
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10..h,),
              SizedBox(
                height: 45..h,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  cursorColor: AppColor.black.withOpacity(.5),
                  obscureText: obscureText,
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
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF9FA3A8),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              Text15(
                text: 'Confirm Password',
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10..h,),
              SizedBox(
                height: 45..h,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  cursorColor: AppColor.black.withOpacity(.5),
                  obscureText: obscureText1,
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
                          obscureText1 = !obscureText1;
                        });
                      },
                      child: Icon(
                        obscureText1 ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF9FA3A8),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 170..h,),
              GestureDetector(
                  onTap: () {
                    navigateToNextScreen(context, EnableLocation());
                  },
                  child: Button(text: 'Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
