import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('${iconPath}confirmed.svg'),
            SizedBox(height: 15..h),
            MainText(
              text: 'Confirmed',
            ),
            SizedBox(height: 30..h),
            Text15(
              text: 'Your Booking has been confirmed \n'
                'for 17 Nov 2023.',
            ),
            SizedBox(height: 20..h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  text: 'Time: ',
                  fontWeight: FontWeight.w500,
                  color: AppColor.black.withOpacity(.5),
                ),
                MainText(
                  text: '03:30 pm',
                ),
              ],
            ),
            SizedBox(height: 20..h),
            Text24(
              text: '\$24.00',
            ),
            SizedBox(height: 40..h),
            Button(
              text: 'Back to Home',
            ),
          ],
        ),
      ),
    );
  }
}
