import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/category_controller/category_controller.dart';
import 'package:labours_konnect/controller/favorite_controller/favorite_controller.dart';
import 'package:labours_konnect/controller/review_controller/review_controller.dart';
import 'package:labours_konnect/controller/service_controller/service_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/models/category_model/category_model.dart';
import 'package:labours_konnect/view/home_screen/categories/categories.dart';
import 'package:labours_konnect/view/home_screen/category_open/category_open.dart';
import 'package:labours_konnect/view/home_screen/details/details.dart';
import 'package:labours_konnect/view/home_screen/filter/filter.dart';

import '../../controller/location_controller/location_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final ServiceController serviceController = Get.put(ServiceController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final LocationController locationController = Get.put(LocationController());

  final ReviewController  reviewController = Get.put(ReviewController());
  List<AddServicesModel> nearbyServices = [];
  bool isLoadingNearbyServices = false;
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
    locationController.handleLocationPermission();
      _fetchNearbyServices();
    // Initialize loading states for all categories
    for (int i = 0; i < 8; i++) {
      _imageLoadingStates[i] = true;
    }
    // Simulate a 2-second delay before hiding the loading indicators
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          for (int i = 0; i < 8; i++) {
            _imageLoadingStates[i] = false;
          }
        });
      }
    });
  }

  Future<void> _fetchNearbyServices() async {
    setState(() {
      isLoadingNearbyServices = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final services = await serviceController.fetchNearbyServices(
        position.latitude,
        position.longitude,
        20, // 20 km radius
      );

      setState(() {
        nearbyServices = services;
      });
    } catch (e) {
      print('Error fetching nearby services: $e');
    } finally {
      setState(() {
        isLoadingNearbyServices = false;
      });
    }
  }
  // double _rating = 5;
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
                  Expanded(
                    child: Row(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubText(
                                text: 'Location',
                                fontSize: 12..sp,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      locationController.currentLocation,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14..sp,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_outlined)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
            isLoadingNearbyServices
                ? Center(child: CircularProgressIndicator())
                : nearbyServices.isEmpty
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Text('No nearby services found'),
            )
                : SizedBox(
              height: 280,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: nearbyServices.length,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    final service = nearbyServices[index];
                    return GestureDetector(
                      onTap: () {
                        navigateToNextScreen(
                            context, Details(service: service));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          children: [
                            Container(
                              width: 210..w,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                image: DecorationImage(
                                  image: service.serviceImage?.isNotEmpty ?? false
                                      ? NetworkImage(service.serviceImage!)
                                      : AssetImage('${imagePath}man.png'),
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
                                      onTap: () {
                                        favoriteController.toggleFavoriteService(service.id);
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
                                            child: service.favorite ? Icon(Icons.favorite,color: AppColor.red,size: 18,) :
                                            Icon(Icons.favorite_border_outlined,color: AppColor.k0xFF818080,size: 18,)
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
                                      text: service.userName,
                                      fontSize: 14..sp,
                                    ),
                                    SubText(
                                      text: service.category,
                                      fontSize: 10..sp,
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
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('${iconPath}map-pin.svg'),
                                        SizedBox(width: 10..w),
                                        Text12(
                                          text: service.city,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
              child: StreamBuilder<List<AddServicesModel>>(
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final service = favoriteServices[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: (){
                            navigateToNextScreen(context, Details(service: service));
                          },
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
                                          image: service.serviceImage?.isNotEmpty ?? false
                                              ? NetworkImage(service.serviceImage!)
                                              : AssetImage('${imagePath}pipe-fitting.png') as ImageProvider,
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
                                            onTap: () async {
                                              final newStatus = await favoriteController.toggleFavoriteService(service.id);
                                              setState(() {
                                                service.favorite = newStatus;
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
                                                child: service.favorite
                                                    ? Icon(Icons.favorite, color: AppColor.red, size: 18)
                                                    : Icon(Icons.favorite_border_outlined, color: AppColor.k0xFF818080, size: 18),
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
                                        text: service.serviceTitle,
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
                                                    image: service.userImage?.isNotEmpty ?? false
                                                        ? NetworkImage(service.userImage!)
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
                                                    text: service.userName,
                                                    fontSize: 14..sp,
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
                                            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.circular(5..r),
                                            ),
                                            child: Center(
                                              child: MainText(
                                                text: '\$ ${service.price}',
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
                        ),
                      );
                    },
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
