import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/book_now_controller/book_now_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';
import 'package:labours_konnect/view/account_screen/payment_method/payment_method.dart';
import 'package:labours_konnect/view/booking_screen/accepted_booking_details/accepted_booking_details.dart';
import 'package:labours_konnect/view/booking_screen/ongoing_booking_details/ongoing_booking_details.dart';
import 'package:labours_konnect/view/booking_screen/pending_booking_details/pending_booking_details.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookNowController bookNowController = Get.put(BookNowController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55..h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainText(
                    text: 'Bookings',
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: 30..h),
              TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColor.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                indicatorColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.black.withOpacity(.5),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black.withOpacity(.5),
                ),
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'On Going',
                  ),
                  Tab(
                    text: 'History',
                  ),
                ],
              ),
              SizedBox(height: 20..h,),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _buildBookingList(bookNowController.fetchBookingsForUser()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _buildBookingList(
                        bookNowController.fetchBookingsForUser(),
                        filter: (booking) => booking.status == 'On Going',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _buildBookingList(
                        bookNowController.fetchBookingsForUser(),
                        filter: (booking) =>
                        booking.status == 'Completed' || booking.status == 'Cancelled',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildBookingList(
    Future<List<BookNowModel>> futureBookings, {
      bool Function(BookNowModel)? filter,
    }) {
  return FutureBuilder<List<BookNowModel>>(
    future: futureBookings,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text("No Booking found"));
      }

      // Apply filter if provided
      final bookings = filter != null
          ? snapshot.data!.where(filter).toList()
          : snapshot.data!;

      return ListView.builder(
        itemCount: bookings.length,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final formattedDate = DateFormat('d MMMM y').format(booking.bookingDate);
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {
                navigateToNextScreen(
                  context,
                  booking.status == 'Accepted'
                      ? PendingBookingDetails(booking: booking)
                      : booking.status == 'On Going'
                      ? PendingBookingDetails(booking: booking)
                      : PendingBookingDetails(booking: booking),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 95..w,
                                height: 30..h,
                                decoration: BoxDecoration(
                                  color: booking.status == 'Accepted'
                                      ? AppColor.bgblue
                                      : booking.status == 'On Going'
                                      ? AppColor.bggreen
                                      : booking.status == 'Completed'
                                      ? AppColor.primaryColor
                                      : AppColor.bgred,
                                  borderRadius: BorderRadius.circular(5..r),
                                ),
                                child: Center(
                                  child: Text15(
                                    fontWeight: FontWeight.w500,
                                    color: booking.status == 'Accepted'
                                        ? AppColor.blue
                                        : booking.status == 'On Going'
                                        ? AppColor.green
                                        : booking.status == 'Completed'
                                        ? AppColor.white
                                        : AppColor.red,
                                    text: booking.status,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5..h),
                              Text16(
                                text: booking.serviceName,
                                fontWeight: FontWeight.w700,
                              ),
                              Text16(
                                text: '\$${booking.price}',
                                color: AppColor.black,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          Container(
                            width: 93..w,
                            height: 84..h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10..r),
                              image: DecorationImage(
                                image: booking.serviceImage.isNotEmpty
                                    ? NetworkImage(booking.serviceImage)
                                    : AssetImage('${imagePath}pipe-fitting.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20..h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'Date & Time:',
                            fontSize: 14..sp,
                          ),
                          Row(
                            children: [
                              Text16(
                                text: formattedDate,
                                fontSize: 12..sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                              SizedBox(width: 10..w),
                              Text16(
                                text: booking.bookingTime,
                                fontSize: 12..sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: AppColor.black.withOpacity(.25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text16(
                            text: 'Provider:',
                            fontSize: 14..sp,
                          ),
                          Text16(
                            text: booking.vendorName,
                            fontSize: 12..sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                          )
                        ],
                      ),
                      SizedBox(height: 10..h),
                      if (booking.status == 'Accepted')
                        GestureDetector(
                          onTap: () {
                            navigateToNextScreen(context, PaymentMethod());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30..h,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10..r),
                            ),
                            child: Center(
                              child: Text16(
                                text: 'Pay Now',
                                fontSize: 15..sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}