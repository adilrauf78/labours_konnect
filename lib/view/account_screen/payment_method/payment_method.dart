import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';
import 'package:labours_konnect/view/account_screen/payment_method/choose_your_card/choose_your_card.dart';

import '../../../controller/book_now_controller/book_now_controller.dart' show BookNowController;

class PaymentMethod extends StatefulWidget {
  final BookNowModel? booking;
  const PaymentMethod({super.key, required this.booking});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final BookNowController bookNowController = Get.put(BookNowController());
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
              SizedBox(height: 55..h),
              Row(
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
                    text: 'Payment Method',
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    width: 20..w,
                  )
                ],
              ),
              SizedBox(height: 30..h),
              Text16(
                text: 'Cash on Delivery',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10..h),
              GestureDetector(
                  onTap: () {
                    bookNowController.OnGoingBooking(widget.booking!.bookingId);
                    Get.back();
                  },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50..h,
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                  child: Row(
                    children: [
                      SvgPicture.asset('${iconPath}cash.svg'),
                      SizedBox(width: 20..w),
                      Text16(
                        text: 'Cash on Delivery',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15..h),
              Text16(
                text: 'Credit & Debit Card',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10..h),
              GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, ChooseYourCard());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50..h,
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                  child: Row(
                    children: [
                      SvgPicture.asset('${iconPath}card.svg'),
                      SizedBox(width: 20..w),
                      Text16(
                        text: 'Choose your Card',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20..h),
            ],
          ),
        ),
      ),
    );
  }
}
