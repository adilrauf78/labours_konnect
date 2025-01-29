import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class SelectMap extends StatelessWidget {
  const SelectMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                    text: 'Add Address',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 20..w),
                ],
              ),
            ),
            SizedBox(height: 25..h),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.55,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('${imagePath}map.png'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Center(
              child: SubText(
                text: 'Confirm your Location',
                fontSize: 16..sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15..r),
                  color: AppColor.black.withOpacity(.1),
                ),
                child: Text16(
                  text: 'H#28 saleem Street # 17 Fiji garhi stop'
                      ' Band Rd, Shera Kot, Lahore, Punjab 54000'
                      'Pakistan',
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: (){
                },
                child: Button(
                  text: 'Next',
                ),
              ),
            ),
            SizedBox(height: 20..h),
          ],
        ),
      ),
    );
  }
}
