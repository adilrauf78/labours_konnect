import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/auth_screens/forget_password/forget_password1.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: ForgetPassword1(),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30..r),
            topLeft: Radius.circular(30..r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 2..h,
                width: 100..w,
                decoration: BoxDecoration(
                  color: AppColor.black.withOpacity(.25),
                  borderRadius: BorderRadius.circular(1)
                ),
              ),
            ),
            SizedBox(height: 25..h,),
            MainText(
              text: 'Forget Password',
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Text(
                  'Enter your email for the verification process, we will send 4 digits code to your email.',
                style: TextStyle(
                  color: AppColor.black.withOpacity(.5),
                  fontSize: 14..sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
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
            SizedBox(height: 80..h,),
            GestureDetector(
                onTap: (){
                  setState(() {
                    _showBottomSheet(context);
                  });
                },
                child: Button(text: 'Sign In'))
          ],
        ),
      ),
    );
  }
}
