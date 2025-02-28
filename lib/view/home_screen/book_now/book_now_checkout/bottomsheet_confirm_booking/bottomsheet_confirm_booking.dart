import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/controller/book_now_controller/book_now_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';


class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  final BookNowController bookNowController = Get.put(BookNowController());
  bool isChecked = false;
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
        child: bookNowController.isLoading
            ? Center(
          child: Container(
            color: Colors.white,
            height: 100,
            width: 100,
            child: SpinKitRing(
              color: AppColor.primaryColor,
              size: 50.0,
            ),
          ),
        )
            :Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('${iconPath}check-circle.svg'),
              SizedBox(height: 20..h),
              Text24(
                text: 'Confirm Booking',
              ),
              SizedBox(height: 10..h),
              Text15(
                text: 'Do you want to complete this \n'
                    'booking?',
              ),
              SizedBox(height: 20..h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 25..w,
                    height: 25..h,
                    child: Checkbox(
                        value: isChecked,
                        checkColor: AppColor.white,
                        activeColor: AppColor.primaryColor,
                        onChanged: (value){
                          setState(() {
                            isChecked = value!;
                          });
                        }
                    ),
                  ),
                  SizedBox(width: 10..w),
                  Expanded(
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree to the ',
                          style: TextStyle(
                            fontSize: 16..sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black.withOpacity(0.5),
                          ),
                          children: [
                            TextSpan(
                              text: 'terms of service',
                              style: TextStyle(
                                fontSize: 16..sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                fontSize: 16..sp,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(
                                fontSize: 16..sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.4,
                      height: 45..h,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10..r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.black.withOpacity(.25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text16(
                          text: 'Cancel',
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (!isChecked) {
                          showSnackBar(title: 'Please agree to the terms of service and privacy policy');
                          return;
                        }
                        try {
                          await bookNowController.bookService('userId'); // Replace 'userId' with actual user ID
                          Get.back(); // Close the confirmation dialog
                          Get.toNamed('/bookingScreen'); // Navigate to the booking screen
                        } catch (e) {
                          showSnackBar(title: 'Failed to book service: $e');
                        }
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.4,
                      height: 45..h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Center(
                        child: Text16(
                          text: 'Confirm',
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
