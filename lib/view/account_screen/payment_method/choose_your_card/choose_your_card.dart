import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/account_screen/payment_method/choose_your_card/add_card/add_card.dart';

class ChooseYourCard extends StatefulWidget {
  const ChooseYourCard({super.key});

  @override
  State<ChooseYourCard> createState() => _ChooseYourCardState();
}

class _ChooseYourCardState extends State<ChooseYourCard> {
  List<Map<String,dynamic>> list = [
    {'path':'${imagePath}visa.png'},
    {'path':'${imagePath}anycard.png'},
    {'path':'${imagePath}mastercard.png'},
  ];
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 55..h,),
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
                    text: 'Credit & Debit Card',
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    width: 20..w,
                  )
                ],
              ),
              SizedBox(height: 30..h,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          value = index;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color : Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(list[index]['path']),
                                SizedBox(width: 15..w,),
                                Text16(text: 'xxxx xxxx xxxx 5647',
                                  fontSize: 16..sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 10..w,),
                                value==index? SvgPicture.asset('${iconPath}check.svg'):Container(),
        
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                list.removeAt(index);
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  SvgPicture.asset('${iconPath}remove.svg'),
                                  SizedBox(width: 5..w,),
                                  Text16(text: 'Remove',
                                    fontSize: 12..sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black.withOpacity(.4),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10..h,),
              GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, AddCard());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 48..h,
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('${iconPath}card.svg'),
                      SizedBox(width: 20..w,),
                      Text16(text: 'Add Card',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
            ],
          ),
        ),
      ),
    );
  }
}
