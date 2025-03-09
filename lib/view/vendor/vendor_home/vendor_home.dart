import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/book_now_controller/book_now_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/book_now_model/book_now_model.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_booking_accepted/vendor_booking_accepted.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_booking_completed/vendor_booking_completed.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_booking_ongoing/vendor_booking_ongoing.dart';
import 'package:labours_konnect/view/vendor/vendor_home/vendor_booking_pending/vendor_booking_pending.dart';
import 'package:labours_konnect/view/vendor/vendor_profile/vendor_profile.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({super.key});

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  final AuthController authController = Get.find<AuthController>();
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 55,left: 20,right: 20,bottom: 15),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20..r),
                    bottomRight: Radius.circular(20..r),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hi, ',
                                    style: TextStyle(
                                      fontSize: 16..sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: authController.fullName.value.isNotEmpty
                                        ? authController.fullName.value
                                        : "null",
                                    style: TextStyle(
                                      fontSize: 16..sp,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8..h),
                            MainText(
                              text: 'Welcome Back!',
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Container(
                          width: 48..w,
                          height: 48..h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            image: DecorationImage(
                              image: AssetImage('${imagePath}pipe.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10..h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColor.k0xFFEEEEEE,
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30..w,
                                height: 30..h,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: SvgPicture.asset('${iconPath}earning.svg'),
                                ),
                              ),
                              SizedBox(width: 10..w),
                              Text16(
                                text: 'Today,s Earning',
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                          Text16(
                            text: '\$100.00',
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20..h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*.41,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text16(
                            text: 'Completed Jobs',
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10..h,),
                          Row(
                            children: [
                              SizedBox(width: 10..w),
                              SvgPicture.asset('${iconPath}jobs.svg'),
                              SizedBox(width: 10..w),
                              Text16(
                                text: '192',
                                fontSize: 18..sp,
                                color: AppColor.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*.41,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10..r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text16(
                            text: 'Total Services',
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10..h,),
                          Row(
                            children: [
                              SizedBox(width: 10..w),
                              SvgPicture.asset('${iconPath}services.svg'),
                              SizedBox(width: 10..w),
                              Text16(
                                text: '5',
                                fontSize: 18..sp,
                                color: AppColor.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                    text: 'Received',
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
                      child: Column(
                        children: [
                          FutureBuilder<List<BookNowModel>>(
                            future: bookNowController.fetchBookingsForVendor(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No bookings found.'));
                              } else {
                                final bookings = snapshot.data!;
                                return ListView.builder(
                                  itemCount: bookings.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final booking = bookings[index];
                                    final formattedDate = DateFormat('d MMMM y').format(booking.bookingDate);

                                    return GestureDetector(
                                      onTap: (){
                                        navigateToNextScreen(context, VendorBookingPending());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                                          color: booking.status == 'Accepted' ? AppColor.bgblue : AppColor.bgred,
                                                          borderRadius: BorderRadius.circular(5..r),
                                                        ),
                                                        child: Center(
                                                          child: Text15(
                                                            fontWeight: FontWeight.w500,
                                                            color: booking.status == 'Accepted' ? AppColor.blue : AppColor.red,
                                                            text: booking.status == 'Accepted' ? 'Accepted' : booking.status,
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
                                              SizedBox(height: 5..h),
                                              SubText(
                                                text: 'Address',
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(height: 5..h),
                                              Text16(
                                                text: booking.location,
                                                fontSize: 15..sp,
                                              ),
                                              SizedBox(height: 5..h),
                                              Divider(
                                                color: AppColor.black.withOpacity(.25),
                                              ),
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
                                                    text: 'Customer:',
                                                    fontSize: 14..sp,
                                                  ),
                                                  Text16(
                                                    text: booking.userName,
                                                    fontSize: 12..sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.black,
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10..h),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.4,
                                                    height: 45..h,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.primaryColor,
                                                      borderRadius: BorderRadius.circular(10..r),
                                                    ),
                                                    child: Center(
                                                      child: Text16(
                                                        text: 'Accept',
                                                        color: AppColor.white,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.4,
                                                    height: 45..h,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius: BorderRadius.circular(10..r),
                                                      border: Border.all(
                                                        color: AppColor.black,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text16(
                                                        text: 'Decline',
                                                        color: AppColor.black,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  navigateToNextScreen(context, VendorBookingAccepted());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                                    color: AppColor.bgblue,
                                                    borderRadius: BorderRadius.circular(5..r),
                                                  ),
                                                  child: Center(
                                                    child: Text15(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.blue,
                                                      text: 'Accepted',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5..h),
                                                Text16(
                                                  text: 'Pipe Fitting',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Text16(
                                                  text: '\$ 120.00',
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
                                                  image: AssetImage('${imagePath}pipe.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5..h),
                                        SubText(
                                          text: 'Address',
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 5..h),
                                        Text16(
                                          text: 'H#28 saleem Street # 17 Fiji garhi stop'
                                              'Band Rd, Shera Kot, Lahore, Punjab 54000 '
                                              'Pakistan',
                                          fontSize: 15..sp,
                                        ),
                                        SizedBox(height: 5..h),
                                        Divider(
                                          color: AppColor.black.withOpacity(.25),
                                        ),
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
                                                  text: '17 Nov 2023',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.black,
                                                ),
                                                SizedBox(width: 10..w),
                                                Text16(
                                                  text: '03:30 pm',
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
                                              text: 'Customer:',
                                              fontSize: 14..sp,
                                            ),
                                            Text16(
                                              text: 'Jack Marston',
                                              fontSize: 12..sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                   navigateToNextScreen(context, VendorBookingOngoing());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                                    color: AppColor.bggreen,
                                                    borderRadius: BorderRadius.circular(5..r),
                                                  ),
                                                  child: Center(
                                                    child: Text15(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.green,
                                                      text: 'On Going',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5..h),
                                                Text16(
                                                  text: 'Pipe Fitting',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Text16(
                                                  text: '\$ 120.00',
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
                                                  image: AssetImage('${imagePath}pipe.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5..h),
                                        SubText(
                                          text: 'Address',
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 5..h),
                                        Text16(
                                          text: 'H#28 saleem Street # 17 Fiji garhi stop'
                                              'Band Rd, Shera Kot, Lahore, Punjab 54000 '
                                              'Pakistan',
                                          fontSize: 15..sp,
                                        ),
                                        SizedBox(height: 5..h),
                                        Divider(
                                          color: AppColor.black.withOpacity(.25),
                                        ),
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
                                                  text: '17 Nov 2023',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.black,
                                                ),
                                                SizedBox(width: 10..w),
                                                Text16(
                                                  text: '03:30 pm',
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
                                              text: 'Customer:',
                                              fontSize: 14..sp,
                                            ),
                                            Text16(
                                              text: 'Jack Marston',
                                              fontSize: 12..sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  navigateToNextScreen(context, VendorBookingCompleted());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                                    color: AppColor.primaryColor,
                                                    borderRadius: BorderRadius.circular(5..r),
                                                  ),
                                                  child: Center(
                                                    child: Text15(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.white,
                                                      text: 'Completed',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5..h),
                                                Text16(
                                                  text: 'Pipe Fitting',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Text16(
                                                  text: '\$ 120.00',
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
                                                  image: AssetImage('${imagePath}pipe.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5..h),
                                        SubText(
                                          text: 'Address',
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 5..h),
                                        Text16(
                                          text: 'H#28 saleem Street # 17 Fiji garhi stop'
                                              'Band Rd, Shera Kot, Lahore, Punjab 54000 '
                                              'Pakistan',
                                          fontSize: 15..sp,
                                        ),
                                        SizedBox(height: 5..h),
                                        Divider(
                                          color: AppColor.black.withOpacity(.25),
                                        ),
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
                                                  text: '17 Nov 2023',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.black,
                                                ),
                                                SizedBox(width: 10..w),
                                                Text16(
                                                  text: '03:30 pm',
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
                                              text: 'Customer:',
                                              fontSize: 14..sp,
                                            ),
                                            Text16(
                                              text: 'Jack Marston',
                                              fontSize: 12..sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                                    color: AppColor.red,
                                                    borderRadius: BorderRadius.circular(5..r),
                                                  ),
                                                  child: Center(
                                                    child: Text15(
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.white,
                                                      text: 'Cancelled',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5..h),
                                                Text16(
                                                  text: 'Pipe Fitting',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                Text16(
                                                  text: '\$ 120.00',
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
                                                  image: AssetImage('${imagePath}pipe.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5..h),
                                        SubText(
                                          text: 'Address',
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 5..h),
                                        Text16(
                                          text: 'H#28 saleem Street # 17 Fiji garhi stop'
                                              'Band Rd, Shera Kot, Lahore, Punjab 54000 '
                                              'Pakistan',
                                          fontSize: 15..sp,
                                        ),
                                        SizedBox(height: 5..h),
                                        Divider(
                                          color: AppColor.black.withOpacity(.25),
                                        ),
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
                                                  text: '17 Nov 2023',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.black,
                                                ),
                                                SizedBox(width: 10..w),
                                                Text16(
                                                  text: '03:30 pm',
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
                                              text: 'Customer:',
                                              fontSize: 14..sp,
                                            ),
                                            Text16(
                                              text: 'Jack Marston',
                                              fontSize: 12..sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
