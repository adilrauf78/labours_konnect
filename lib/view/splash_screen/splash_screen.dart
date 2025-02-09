import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/onboarding_controller/onboarding_controller.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';
import 'package:labours_konnect/view/onboarding_screen/onboarding_screen.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingController onboardingController = Get.put(OnboardingController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () async {
        if (onboardingController.isLaunched.isTrue) {
          Get.off(OnboardingScreen()); // Pehli baar app chalane par OnboardingScreen par jao
        } else {
          // Check login status
          bool isLoggedIn = await authController.checkLoginStatus();
          if (isLoggedIn) {
            // Agar user logged in hai, toh toggle state check karo
            if (authController.isProfessionalMode.value) {
              Get.off(VendorBottomNavigator()); // Agar toggle on hai, toh VendorBottomNavigator par jao
            } else {
              Get.off(BottomNavigator()); // Agar toggle off hai, toh BottomNavigator par jao
            }
          } else {
            Get.off(SignInScreen()); // Agar user logged in nahi hai, toh SignInScreen par jao
          }
        }
      },
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