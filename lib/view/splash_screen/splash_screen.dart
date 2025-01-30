import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/onboarding_controller/onboarding_controller.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';
import 'package:labours_konnect/view/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingController onboardingController = Get.put(OnboardingController());
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),(){
      if(onboardingController.isLaunched.isTrue){
        Get.off(OnboardingScreen());
      }
      else{
        Get.off(SignInScreen());
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Text(
            'Labours Konnect',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              fontSize: 50..sp,
            ),
          ),
        ),
      ),
    );
  }
}
