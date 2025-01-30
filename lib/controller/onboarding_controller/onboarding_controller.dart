import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController{

  var isLaunched = true.obs;

  @override
  void onInit() {
    checkFirstLaunch();
    super.onInit();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    if(seenOnboarding){
      isLaunched.value = false;
    }
  }

  Future<void> CompleteOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    isLaunched.value = false;
  }


}