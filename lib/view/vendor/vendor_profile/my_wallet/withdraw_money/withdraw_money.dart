import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_button/custom_button.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';

class WithdrawMoney extends StatefulWidget {
  const WithdrawMoney({super.key});

  @override
  State<WithdrawMoney> createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  void _showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16..r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(15..r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(
                        text: 'Withdraw Request',
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close_outlined,color: AppColor.black,),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColor.black.withOpacity(.1),
                ),
                SizedBox(height: 20..h),
                SvgPicture.asset('${iconPath}submited.svg'),
                SizedBox(height: 20..h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text15(
                    text: 'Your Withdraw Request is Submitted',
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 20..sp,
                  ),
                ),
                SizedBox(height: 15..h),
                Text12(
                  text: 'You received your money within 14 days',
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
                SizedBox(height: 50..h),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Button(
                      text: 'Back to Home',
                    ),
                  ),
                ),
                SizedBox(height: 20..h),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  child: Icon(Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18,
                  ),
                ),
                MainText(
                  text: 'Withdraw Money',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 60..h),
            SubText(
              text: 'Total Earning',
            ),
            SizedBox(height: 20..h),
            Container(
              width: 130..w,
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.black.withOpacity(.25),
                  )
                )
              ),
              child: TextField(
                textAlign: TextAlign.center,
                cursorColor: AppColor.black.withOpacity(.5),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    fillColor: AppColor.white,
                    filled: true,
                    hintText: '\$70.00',
                    hintStyle: TextStyle(
                      color: AppColor.black,
                      fontSize: 36..sp,
                      fontWeight: FontWeight.w700,
                    )
                ),
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 36..sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 30..h),
            MainText(
              text: '580.00',
            ),
            SizedBox(height: 5..h,),
            SubText(
              text: 'Available Balance',
            ),
            SizedBox(height: 70..h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('${iconPath}withdraw-money.svg'),
                    SizedBox(width: 10..w),
                    SubText(
                      text: 'Withdraw Money To',
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(5..r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add,color: AppColor.white,),
                      SizedBox(width: 5..w),
                      SubText(
                        text: 'Add Beneficiary',
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20..h),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(
                  color: AppColor.black,
                ),
                borderRadius: BorderRadius.circular(5..r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('${iconPath}bank.svg'),
                      SizedBox(width: 15..w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text12(
                            text: 'Abudhabi commercial Bank',
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                            fontSize: 14..sp,
                          ),
                          Text12(
                            text: '**** **** **** **** 4327',
                            fontWeight: FontWeight.w700,
                            color: AppColor.black,
                            fontSize: 14..sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset('${iconPath}check.svg'),
                ],
              ),
            ),
            SizedBox(height: 180..h,),
            GestureDetector(
              onTap: (){
                setState(() {
                  _showCustomPopup(context);
                });
              },
              child: Button(
                text: 'Submit',
              ),
            ),
            SizedBox(height: 30..h,),
          ],
        ),
      ),
    );
  }
}
