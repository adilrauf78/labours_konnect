import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/main.dart';

showSnackBar({Color? color, String? title}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
        backgroundColor: color ?? Color(0xFF494949),
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
        content:Text(
          title ?? "Something went wrong. Please check and try again.",
          style: TextStyle(
              fontSize: 14..sp,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),
        )),
  );
}


void ErrorSnackBar(String title,String message) {
  Get.snackbar(
    title,
    message,
    messageText: Text(
      message,
      style: TextStyle(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void SuccessSnackBar(String title,String message) {
  Get.snackbar(
    title,
    message,
    messageText: Text(
      message,
      style: TextStyle(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}