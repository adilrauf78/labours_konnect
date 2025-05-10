import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/favorite_controller/favorite_controller.dart';
import 'package:labours_konnect/controller/review_controller/review_controller.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/home_screen/details/details.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ReviewController  reviewController = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 55
            ..h,),
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
                    size: 18,
                  ),
                ),
                MainText(
                  text: 'Favorite',
                  fontWeight: FontWeight.w500,
                ),
                Container(
                  width: 20
                    ..w,
                )
              ],
            ),
          ),
          SizedBox(height: 30
            ..h,),
          StreamBuilder<List<AddServicesModel>>(
            stream: favoriteController.fetchFavoriteServices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
          
              if (snapshot.hasError) {
                return Center(child: Text('Error loading favorites'));
              }
          
              final favoriteServices = snapshot.data ?? [];
          
              if (favoriteServices.isEmpty) {
                return Center(child: Text('No favorite services yet'));
              }
          
              return ListView.builder(
                itemCount: favoriteServices.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final service = favoriteServices[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: (){
                        navigateToNextScreen(context, Details(service: service,));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFFBFBFB),
                          borderRadius: BorderRadius.circular(10..r),
                          border: Border.all(
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 130..w,
                                  height: 160..h,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    image: DecorationImage(
                                      image: service.serviceImage?.isNotEmpty ?? false
                                          ? NetworkImage(service.serviceImage!)
                                          : AssetImage('${imagePath}painter.png') as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(5..r),
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final newStatus = await favoriteController.toggleFavoriteService(service.id);
                                        setState(() {
                                          service.favorite = newStatus;
                                        });
                                      },
                                      child: Container(
                                        width: 25.w,
                                        height: 25.h,
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
                                          child: service.favorite
                                              ? Icon(Icons.favorite, color: AppColor.red, size: 18)
                                              : Icon(Icons.favorite_border_outlined, color: AppColor.k0xFF818080, size: 18),
                                        ),
                                      ),
                                    )

                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 5,
                                  child: Container(
                                    width: 85..w,
                                    height: 20..h,
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5..r),
                                    ),
                                    child: Center(
                                      child: Text18(
                                        text: 'Level two',
                                        color: AppColor.white,
                                        fontSize: 12..sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10..w),
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 2..h),
                                      MainText(
                                        text: service.serviceTitle,
                                      ),
                                      SubText(
                                        text: service.category,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 16, color: Color(0xFFFFD800)),
                                          SizedBox(width: 3..w),
                                          FutureBuilder<double>(
                                            future: reviewController.getAverageRating(service.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return MainText(
                                                  text: '...',
                                                  fontSize: 15..sp,
                                                  fontWeight: FontWeight.w500,
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                return MainText(
                                                  text: '0.0',
                                                  fontSize: 15..sp,
                                                  fontWeight: FontWeight.w500,
                                                );
                                              }
                                              return MainText(
                                                text: snapshot.data!.toStringAsFixed(1),
                                                fontSize: 15..sp,
                                                fontWeight: FontWeight.w500,
                                              );
                                            },
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          SvgPicture.asset('${iconPath}map-pin.svg'),
                                          SizedBox(width: 10..w),
                                          Expanded(
                                            child: Text12(
                                              text: service.location,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25..h),
                                  Container(
                                    height: 40..h,
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(10..r),
                                    ),
                                    child: Center(
                                      child: Text16(
                                        text: 'Book Now',
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
