import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/review_controller/review_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';

class RateServices extends StatefulWidget {
  final BookNowModel booking;
  const RateServices({super.key, required this.booking});

  @override
  State<RateServices> createState() => _RateServicesState();
}

class _RateServicesState extends State<RateServices> {
  final ReviewController reviewController = Get.put(ReviewController());
  double _rating = 0;
  @override
  void initState() {
    super.initState();
    // Initialize rating from controller
    reviewController.selectedRating.value = 0;
    reviewController.reviewCommentController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40..r),
            topLeft: Radius.circular(40..r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainText(
                text: 'Rate this Service?',
              ),
              SizedBox(height: 5..h),
              Obx(() => RatingBar.builder(
                initialRating: reviewController.selectedRating.value,
                minRating: 1,
                itemCount: 5,
                itemSize: 35.sp,
                itemPadding: EdgeInsets.only(right: 10.w),
                direction: Axis.horizontal,
                unratedColor: Colors.black.withOpacity(.25),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Color(0xFFFFD800),
                ),
                onRatingUpdate: (rating) {
                  reviewController.selectedRating.value = rating;
                },
              )),
              SizedBox(height: 25..h),
              Text15(
                text: 'Please share your opinion \n'
                  'about this service',
                color: AppColor.black.withOpacity(.7),
              ),
              SizedBox(height: 20..h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150..h,
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
                child: TextField(
                  controller: reviewController.reviewCommentController,
                  maxLines: null,
                  expands: true,
                  cursorColor: Color(0xFF9FA3A8),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(11),
                    hintText: 'Write a review',
                    hintStyle: TextStyle(
                      fontSize: 14..sp,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 25..h),
              Obx(() => GestureDetector(
                onTap: reviewController.isLoading.value
                    ? null
                    : () async {
                  await reviewController.addReview(
                    serviceId: widget.booking.serviceId,
                    serviceOwnerId: widget.booking.vendorId,
                  );
                },
                child: reviewController.isLoading.value
                    ? CircularProgressIndicator()
                    : Button(text: 'Submit'),
              )),
            ],
          ),
        )
    );
  }
}
