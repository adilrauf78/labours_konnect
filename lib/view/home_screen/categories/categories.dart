import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/category_model/category_model.dart';
import 'package:labours_konnect/controller/category_controller/category_controller.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/view/home_screen/category_open/category_open.dart';

class Categories extends StatefulWidget {


  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateBackWithAnimation(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18,
                  ),
                ),
                MainText(
                  text: 'Categories',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 20..h),
            Container(
              height: 45..h,
              child: TextField(
                controller: categoryController.searchController,
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
                    ),
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
                  ),
                ),
              ),
            ),
            SizedBox(height: 20..h),
            Expanded(
              child: FutureBuilder<List<CategoryModel>>(
                future: categoryController.fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20..h),
                        Center(child: CircularProgressIndicator()),
                      ],
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
                    return ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            navigateToNextScreen(context, CategoryOpen(category: category));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColor.black.withOpacity(.1),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60..w,
                                  height: 60..h,
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
                                  child: Center(
                                    child: category.imagePath.isNotEmpty
                                        ? Image.network(
                                      category.imagePath,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return CircularProgressIndicator();
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return SvgPicture.asset('${iconPath}paint-roller.svg'); // Fallback icon
                                      },
                                    )
                                        : SvgPicture.asset('${iconPath}paint-roller.svg'), // Fallback icon
                                  ),
                                ),
                                SizedBox(width: 20..w),
                                SubText(
                                  text: category.category, // Display category name
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}