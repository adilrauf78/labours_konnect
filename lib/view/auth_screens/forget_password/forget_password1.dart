import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';

class ForgetPassword1 extends StatelessWidget {
  const ForgetPassword1({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 2..h,
              width: 100..w,
              decoration: BoxDecoration(
                  color: AppColor.black.withOpacity(.25),
                  borderRadius: BorderRadius.circular(1)
              ),
            ),
            SizedBox(height: 25..h,),
            SvgPicture.asset('${iconPath}email1.svg'),
            SizedBox(height: 30..h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Reset Password link is successfully sent on your email or mobile number',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16..sp,
                  fontWeight: FontWeight.w400,
                  ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Please check your email to reset your password',
                style: TextStyle(
                  color: AppColor.black.withOpacity(.5),
                  fontSize: 15..sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40..h,),
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Button(text: 'Continue Sign In'))
          ],
        ),
      ),
    );
  }
}
