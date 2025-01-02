import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 55..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateBackWithAnimation(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    MainText(
                      text: 'My Location',
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      width: 20..w,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30..h),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                  ),
                  child: Image.asset('${imagePath}map.png',fit: BoxFit.fill,),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15..r),
                  topLeft: Radius.circular(15..r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 2..h,
                    width: 100..w,
                    decoration: BoxDecoration(
                        color: AppColor.black.withOpacity(.25),
                        borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  SizedBox(height: 20..h),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(),
                      );

                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
