import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';

class ConfirmLocation extends StatelessWidget {
  const ConfirmLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('${imagePath}map.png'),
                    fit: BoxFit.fill
                ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateBackWithAnimation(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                        color: AppColor.black,
                        size: 18,
                      ),
                    ),
                    SubText(text: 'Cancel',
                      fontSize: 16..sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD40000),
                    ),
                  ],
                ),
                SizedBox(height: 20..h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5..w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubText(text: 'H#28 saleem Street # 17 Fiji garhi stop,',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.borderColor,
                          ),
                          SubText(text: 'Kuwait',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.borderColor,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, BottomNavigator());
                },
                child: Button(
                    text: 'Confirm Location'),
            ),
          )
        ],
      ),
    );
  }
}
