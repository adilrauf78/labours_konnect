import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  var isProfessionalMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSwitchState();
  }

  // Save the switch state to SharedPreferences
  Future<void> saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_professional_mode', value);
    isProfessionalMode.value = value;
  }

  // Load the switch state from SharedPreferences
  Future<void> loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    isProfessionalMode.value = prefs.getBool('is_professional_mode') ?? false;
  }

  // Toggle the switch and handle navigation
  void toggleSwitch(bool value, BuildContext context) {
    isProfessionalMode.value = value;
    saveSwitchState(value);
    if (value) {
      Future.delayed(Duration(milliseconds: 300), () {
        navigateToNextScreen(context, VendorBottomNavigator());
      });
    } else {
      Future.delayed(Duration(milliseconds: 300), () {
        navigateToNextScreen(context, BottomNavigator());
      });
    }
  }
}