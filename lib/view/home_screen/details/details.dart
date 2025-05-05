import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/controller/review_controller/review_controller.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';
import 'package:labours_konnect/models/user_model/user_model.dart';
import 'package:labours_konnect/view/home_screen/book_now/book_now.dart';
import 'package:labours_konnect/view/message_screen/chat_screen/chat_screen.dart';


class Details extends StatefulWidget {
  final AddServicesModel service;
  const Details({super.key, required this.service});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final ServiceController serviceController = Get.find<ServiceController>();
  final ChatController chatController = Get.put(ChatController());
  final ReviewController reviewController = Get.put(ReviewController());
  bool favorite = true;
  bool favorite1 = true;
  // @override
  // void initState() {
  //   super.initState();
  //   reviewController.fetchReviews(widget.service.id);
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 55..h),
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
                            color: AppColor.black,
                            size: 18,
                          ),
                        ),
                        MainText(
                          text: 'Details',
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 20..w),
                      ],
                    ),
                  ),
                  SizedBox(height: 30..h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 87..w,
                          height: 87..h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            image: DecorationImage(
                              image: AssetImage('${imagePath}pipe.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15..w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: widget.service.userName ?? 'null',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 5..h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(5..r),
                              ),
                              child: Center(
                                child: Text16(
                                  text: widget.service.category,
                                  fontSize: 14..sp,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5..h),
                            Row(
                              children: [
                                SvgPicture.asset('${iconPath}map-pin.svg'),
                                SizedBox(width: 10..w),
                                Text(
                                  widget.service.location,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColor.black.withOpacity(.5),
                                    fontSize: 12..sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),


                              ],
                            ),
                          ]
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20..h),
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
                        text: 'Details',
                      ),
                      Tab(
                        text: 'Services',
                      ),
                      Tab(
                        text: 'Reviews',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubText(
                                text: widget.service.description,
                                fontSize: 12..sp,
                              ),
                              SizedBox(height: 10..h),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300..h,
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      image: DecorationImage(
                                        image: AssetImage('${imagePath}work.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15..r),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
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
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          favorite = !favorite;
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
                                            child: favorite ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 24,) :
                                            Icon(Icons.favorite,color: AppColor.red,size: 24,)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(left: 20,right: 50,top: 15,bottom: 7),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.black.withOpacity(.25),
                                            blurRadius: 4,
                                          )
                                        ],
                                          gradient: LinearGradient(
                                            colors: [AppColor.black.withOpacity(.7), AppColor.black.withOpacity(.35)],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15..r),
                                          bottomLeft: Radius.circular(15..r),
                                        )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                SubText(
                                                  text: 'Jobs',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.white,
                                                ),
                                                SizedBox(height: 2..h),
                                                SubText(
                                                  text: '137',
                                                  fontSize: 18..sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                SubText(
                                                  text: 'Experience',
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.white,
                                                ),
                                                SizedBox(height: 2..h),
                                                Row(
                                                  children: [
                                                    SubText(
                                                      text: widget.service.experience,
                                                      fontSize: 18..sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.white,
                                                    ),
                                                    SizedBox(width: 5..w),
                                                    SubText(
                                                      text: 'Years',
                                                      fontSize: 13..sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Icon(Icons.star,color: AppColor.white,size: 20,),
                                                SizedBox(height: 2..h),
                                                FutureBuilder<void>(
                                                  future: reviewController.fetchReviews(widget.service.id), // 👈 Use actual ID field
                                                  builder: (context, snapshot) {
                                                    return SubText(
                                                      text: reviewController
                                                          .averageRating.value
                                                          .toStringAsFixed(1),
                                                      fontSize: 18
                                                        ..sp,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      color: AppColor.white,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              FutureBuilder<List<AddServicesModel>>(
                                future: serviceController.fetchUserServices(widget.service.userId), // Fetch services for specific user
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text('No services found.'));
                                  } else {
                                    final services = snapshot.data!;
                                    return ListView.builder(
                                      itemCount: services.length, // Dynamic item count
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final service = services[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
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
                                                          image: serviceController.imagePath.isNotEmpty
                                                              ? NetworkImage(serviceController.imagePath.value)
                                                              : AssetImage('${imagePath}pipe-fitting.png'),
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
                                                      SubText(
                                                        text: service.serviceTitle,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16..sp,
                                                      ),
                                                      SizedBox(height: 10..h),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 34..w,
                                                                height: 34..h,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: AppColor.white,
                                                                  image: DecorationImage(
                                                                    image: AssetImage('${imagePath}pipe.png'),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 10..w),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  MainText(
                                                                    text: service.userName ?? 'Unknown User', // Use 'Unknown User' if userName is null
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
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
                                                                      return Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          RatingBarIndicator(
                                                                            rating: snapshot.data ?? 0.0,
                                                                            itemCount: 5,
                                                                            itemSize: 12,
                                                                            itemPadding: EdgeInsets.only(right: 2),
                                                                            direction: Axis.horizontal,
                                                                            unratedColor: Color(0xFFF9E005).withOpacity(.5),
                                                                            itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                                                                          ),
                                                                          SizedBox(width: 5..w),
                                                                          Text(
                                                                            snapshot.data!.toStringAsFixed(1),
                                                                            style: TextStyle(
                                                                              color: AppColor.black,
                                                                              fontSize: 10..sp,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  )

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 13,vertical: 8),
                                                            decoration: BoxDecoration(
                                                              color: AppColor.primaryColor,
                                                              borderRadius: BorderRadius.circular(5..r),
                                                            ),
                                                            child: Center(
                                                              child: MainText(
                                                                text: '\$ ${service.price}.00',
                                                                fontSize: 14..sp,
                                                                color: AppColor.white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: FutureBuilder<void>(
                            future: reviewController.fetchReviews(widget.service.id), // 👈 Use actual ID field
                            builder: (context, snapshot) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text18(
                                        text: 'Reviews ',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Obx(() => Text18(
                                        text: '(${reviewController.reviews.length})',
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.black.withOpacity(.25),
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10..h),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: reviewController.averageRating.value,
                                        itemCount: 5,
                                        itemSize: 22..sp,
                                        itemPadding: EdgeInsets.only(right: 5..w),
                                        unratedColor: Color(0x4DF9E005),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Color(0xFFFFD800),
                                        ),
                                      ),
                                      SizedBox(width: 15..w),
                                      MainText(
                                        text: reviewController.averageRating.value.toStringAsFixed(1),
                                      ),
                                    ],

                                  ),
                                  SizedBox(height: 10..h),
                                  Divider(
                                    color: AppColor.black.withOpacity(.1),
                                  ),
                                  SizedBox(height: 15..h),
                                  // Reviews List
                                  Obx(() {
                                    if (reviewController.isLoading.value && reviewController.reviews.isEmpty) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    if (reviewController.reviews.isEmpty) {
                                      return Center(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 40..h),
                                            Icon(Icons.reviews, size: 50..sp, color: Colors.grey),
                                            SizedBox(height: 10..h),
                                            Text(
                                              'No reviews yet',
                                              style: TextStyle(
                                                fontSize: 14..sp,
                                                color: AppColor.black.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: reviewController.reviews.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final review = reviewController.reviews[index];
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 20..h),
                                          child: Container(
                                            padding: EdgeInsets.all(12..w),
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
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 30..w,
                                                          height: 30..h,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: AppColor.white,
                                                            image: DecorationImage(
                                                              image: review.reviewerImage?.isNotEmpty ?? false
                                                                  ? NetworkImage(review.reviewerImage!)
                                                                  : AssetImage('${imagePath}pipe.png'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10..w),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MainText(
                                                              text: review.reviewerName,
                                                              fontSize: 12..sp,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            Text(
                                                              '${review.timestamp.day}/${review.timestamp.month}/${review.timestamp.year}',
                                                              style: TextStyle(
                                                                color: AppColor.black,
                                                                fontSize: 8..sp,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: review.rating,
                                                          itemCount: 5,
                                                          itemSize: 12..sp,
                                                          itemPadding: EdgeInsets.only(right: 2..w),
                                                          direction: Axis.horizontal,
                                                          unratedColor: Color(0x4DF9E005),
                                                          itemBuilder: (context, _) => Icon(
                                                            Icons.star,
                                                            color: Color(0xFFFFD800),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5..w),
                                                        Text(
                                                          review.rating.toStringAsFixed(1),
                                                          style: TextStyle(
                                                            color: AppColor.black,
                                                            fontSize: 10..sp,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10..h),
                                                SubText(
                                                  text: review.comment,
                                                  fontSize: 12..sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navigateToNextScreen(context, ChatScreen(
                          userName: widget.service.userName ?? 'Unknown User',
                          userId: widget.service.userId,
                          chatId: chatController.generateChatId(chatController.currentUserId, widget.service.userId,)
                        ),);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*.4,
                        height: 45..h,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10..r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.k0xFFEEEEEE,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('${iconPath}messages.svg',color: AppColor.black,),
                            SizedBox(width: 10..w),
                            Text16(
                              text: 'Message',
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navigateToNextScreen(context, BookNow(service: widget.service,));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*.4,
                        height: 45..h,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10..r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.k0xFFEEEEEE,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text16(
                            text: 'Book Now',
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
