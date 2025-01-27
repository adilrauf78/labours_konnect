import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/home_screen/book_now/book_now.dart';


class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool favorite = true;
  bool favorite1 = true;
  double _rating = 5;
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
                              text: 'Jack Marston',
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
                                  text: 'Plumbing',
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
                                Text12(
                                  text: 'Woodstock, GA',
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
                            children: [
                              SubText(
                                text: 'Hey, I\'m Jack Marston and expert of plumb servicing. I having more than 2 years of working '
                                    'experience. I appreciate the best delivery from my side. Hey, I\'m Jack Marston and expert of plumb '
                                    'servicing. I having more than 2 years of working experience Read More...',
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
                                                      text: '4',
                                                      fontSize: 18..sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.white,
                                                    ),
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
                                                SubText(
                                                  text: '5.0',
                                                  fontSize: 18..sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.white,
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
                              ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
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
                                                SubText(
                                                  text: 'Pipe Fitting',
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
                                                          children: [
                                                            MainText(
                                                              text: 'Jack Marston',
                                                              fontSize: 14..sp,
                                                              fontWeight: FontWeight.w500,
                                                            ),
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
                                                          text: '\$ 20.00',
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
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text18(
                                    text: 'Reviews ',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  Text18(
                                    text: '(64)',
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.black.withOpacity(.25),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10..h,),
                              Row(
                                children: [
                                  RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemPadding: EdgeInsets.only(right: 5),
                                      direction: Axis.horizontal,
                                      unratedColor: Color(0x4DF9E005),
                                      itemBuilder: (context, index)=>Icon(Icons.star,color: Color(0xFFFFD800)),
                                      onRatingUpdate: (rating1){
                                        setState(() {
                                          _rating = _rating;
                                        });
                                      }
                                  ),
                                  SizedBox(width: 15..w),
                                  MainText(
                                    text: '$_rating',
                                  ),
                                ],
                              ),
                              SizedBox(height: 10..h,),
                              Divider(
                                color: AppColor.black.withOpacity(.1),
                              ),
                              SizedBox(height: 15..h,),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      child: Column(
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
                                                        text: 'Jack Marston',
                                                        fontSize: 12..sp,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      Text(
                                                        'Nov 15, 2021',
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
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15..h),
                                          SubText(
                                            text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                                                'incididunt utertid labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '
                                                'exercitation ullamco aruun laboris nisi ut aliquip ex ea commodo consequat.',
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
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
                    Container(
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
                    GestureDetector(
                      onTap: (){
                        navigateToNextScreen(context, BookNow());
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
