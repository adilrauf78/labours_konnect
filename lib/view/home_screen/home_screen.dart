import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/category_controller/category_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/category_model/category_model.dart';
import 'package:labours_konnect/view/home_screen/categories/categories.dart';
import 'package:labours_konnect/view/home_screen/category_open/category_open.dart';
import 'package:labours_konnect/view/home_screen/filter/filter.dart';

import '../../controller/location_controller/location_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final LocationController locationController = Get.put(LocationController());
  final Map<int, bool> _imageLoadingStates = {};

  List<Map<String, dynamic>> images =[
    {'path': 'assets/images/electrician.png'},
    {'path': 'assets/images/painterr.png'},
    {'path': 'assets/images/plumber.png'},
    {'path': 'assets/images/cleaner.png'},
    {'path': 'assets/images/carpenter.png'},
    {'path': 'assets/images/beauty.png'},
    {'path': 'assets/images/cctv.png'},
    {'path': 'assets/images/ac-repair.png'},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize loading states for all categories
    for (int i = 0; i < 8; i++) {
      _imageLoadingStates[i] = true;
    }
    // Simulate a 2-second delay before hiding the loading indicators
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          for (int i = 0; i < 8; i++) {
            _imageLoadingStates[i] = false;
          }
        });
      }
    });
  }
  bool favorite = true;
  bool favorite1 = true;
  double _rating = 5;
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          child: Filter(),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 35..w,
                        height: 35..h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50..r),
                          child: Image.asset('${imagePath}image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20..w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubText(
                            text: 'Location',
                            fontSize: 12..sp,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text12(
                                  text: 'Barbican, Jamaica',
                                  fontSize: 14..sp,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 35..w,
                    height: 35..h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.k0xFF818080,
                      ),
                    ),
                    child: Center(
                        child: SvgPicture.asset('${iconPath}bell.svg')
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45..h,
                      child: TextField(
                        cursorColor: AppColor.black.withOpacity(.5),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10..r),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEEEEE),
                                ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10..r),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEEEEE),
                                )
                            ),
                            contentPadding: EdgeInsets.zero,
                            fillColor: AppColor.white,
                            filled: true,
                            prefixIcon: Transform.scale(
                              scale: 0.45,
                              child: SvgPicture.asset('${iconPath}search.svg'),
                            ),
                            hintText: 'Search here ',
                            hintStyle: TextStyle(
                              color: AppColor.black.withOpacity(.3),
                              fontSize: 15..sp,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10..w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showBottomSheet(context);
                      });
                    },
                    child: Container(
                      width: 45..w,
                      height: 45..h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10..r),
                        border: Border.all(
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                      child: Center(
                          child: SvgPicture.asset('${iconPath}filter.svg'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'Categories',
                          fontSize: 18..sp,
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: (){
                            navigateToNextScreen(context, Categories());
                          },
                          child: Text(
                            'More',
                            style: TextStyle(
                              color: AppColor.red,
                              fontSize: 14..sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10..h),
                FutureBuilder<List<CategoryModel>>(
                  future: categoryController.fetchCategories(), // Fetch categories
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No categories found"),
                      );
                    } else {
                      final categories = snapshot.data!;
                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: (1 / 1.59),
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: List.generate(
                          categories.length > 8 ? 8 : categories.length,
                              (index) {
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                navigateToNextScreen(context, CategoryOpen(category: category));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 60..w,
                                      height: 60..h,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.black.withOpacity(.25),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child:  _imageLoadingStates[index] ?? true
                                          ? Center(
                                        child: CircularProgressIndicator(), // Show loading indicator for 2 seconds
                                      )
                                          :Center(
                                        child: category.imagePath.isNotEmpty
                                            ? Image.network(
                                          category.imagePath,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return CircularProgressIndicator();
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(images[index]['path']);
                                          },
                                        )
                                            : Image.asset(images[index]['path']),
                                      ),
                                    ),
                                    SizedBox(height: 5..h),
                                    Text15(
                                      text: category.category,
                                      fontSize: 12..sp,
                                      color: AppColor.black,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                    SizedBox(height: 10..h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: MainText(
                text: 'Near to your address',
                fontSize: 16..sp,
              ),
            ),
            SizedBox(height: 20..h),
            SizedBox(
              height: 280,
              child: ListView.builder(
                itemCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          width: 210..w,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            image: DecorationImage(
                              image: AssetImage('${imagePath}man.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10..r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.k0xFFEEEEEE,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 8,
                          right: 10,
                          top: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    favorite = !favorite;
                                  });
                                },
                                child: Container(
                                  width: 25..w,
                                  height: 25..h,
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
                                      child: favorite ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 18,) :
                                      Icon(Icons.favorite,color: AppColor.red,size: 18,)
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 210..w,
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5,),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10..r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.k0xFFEEEEEE,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MainText(
                                  text: 'Jack marston',
                                  fontSize: 14..sp,
                                ),
                                SubText(
                                  text: 'Plumber',
                                  fontSize: 10..sp,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('${iconPath}map-pin.svg'),
                                    SizedBox(width: 10..w),
                                    Text12(
                                      text: 'Woodstock, GA',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20..h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: MainText(
                text: 'Featured Services',
                fontSize: 16..sp,
              ),
            ),
            SizedBox(height: 20..h),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 290..w,
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
                                width: 290..w,
                                height: 200..h,
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
                                left: 8,
                                right: 10,
                                top: 8,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
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
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            favorite1 = !favorite1;
                                          });
                                        },
                                        child: Container(
                                          width: 25..w,
                                          height: 25..h,
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
                                              child: favorite1 ? Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 18,) :
                                              Icon(Icons.favorite,color: AppColor.red,size: 18,)
                                          ),
                                        ),
                                      ),
                                    ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text16(
                                  text: 'Pipe Fitting',
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
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
              ),
            ),
            SizedBox(height: 50..h),
          ],
        ),
      ),
    );
  }
}
