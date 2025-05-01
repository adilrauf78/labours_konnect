import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/book_now_controller/book_now_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';
import 'package:labours_konnect/view/booking_screen/ongoing_booking_details/bottomsheet_complete_booking/rate_services.dart';

class CompleteBooking extends StatefulWidget {
  final BookNowModel booking;
  const CompleteBooking({super.key, required this.booking});

  @override
  State<CompleteBooking> createState() => _CompleteBookingState();
}

class _CompleteBookingState extends State<CompleteBooking> {
  final BookNowController bookNowController = Get.find<BookNowController>();
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: RateServices(booking: widget.booking),
        );
      },
    );
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
            SvgPicture.asset('${iconPath}check-circle.svg'),
            SizedBox(height: 20..h),
            Text24(
              text: 'Complete Booking',
            ),
            SizedBox(height: 20..h),
            Text15(
              text: 'Do you want to complete this \n'
                'booking?',
            ),
            SizedBox(height: 40..h),
            GestureDetector(
              onTap: () async {
                //await bookNowController.markBookingAsCompleted(widget.booking.bookingId);
                  setState(() {
                    _showBottomSheet(context);
                  });
              },
              child: Button(
                text: 'Done',
              ),
            ),
          ],
        ),
      )
    );
  }
}
