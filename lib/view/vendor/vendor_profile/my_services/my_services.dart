import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/my_services/service_details/service_details.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  bool favorite1 = true;
  double _rating = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Row(
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
                  text: 'My Services',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 30..h),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: (){
                      navigateToNextScreen(context, ServiceDetails());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 160..h,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  image: DecorationImage(
                                    image: AssetImage('${imagePath}pipe-fitting.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10..r),
                                    topRight: Radius.circular(10..r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.k0xFFEEEEEE,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      favorite1 = !favorite1;
                                    });
                                  },
                                  child: Container(
                                    width: 40..w,
                                    height: 40..h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.k0xFFEEEEEE,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: favorite1 ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 24,) :
                                        Icon(Icons.favorite,color: AppColor.red,size: 24,)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        RatingBar.builder(
                                            initialRating: 5,
                                            minRating: 1,
                                            itemCount: 5,
                                            itemSize: 12,
                                            itemPadding: EdgeInsets.only(right: 2),
                                            direction: Axis.horizontal,
                                            unratedColor: Color(0x4DF9E005),
                                            itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                                            onRatingUpdate: (rating1){
                                              setState(() {
                                                _rating = _rating;
                                              });
                                            }
                                        ),
                                        SizedBox(width: 5..w),
                                        Text(
                                          '$_rating',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 10..sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 13,vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(5..r),
                                      ),
                                      child: Center(
                                        child: MainText(
                                          text: '\$ 20.00',
                                          fontSize: 14..sp,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5..h),
                                SubText(
                                  text: 'Pipe Fitting',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16..sp,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
