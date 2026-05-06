import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/onbording/screen/onbording_screen.dart'
    show OnboardingScreen;
import '../../navigation_ber/screen/bottom_navigation_ber.dart'
    show BottomNavbar;

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }

  void checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String planName = prefs.getString('planName') ?? "Basic";
    Timer(const Duration(seconds: 3), () {
      debugPrint("===============$accessToken");
      if (accessToken != null) {
        Get.offAll(() => BottomNavbar(), arguments: planName);
      } else {
        Get.offAll(() => OnboardingScreen());
      }
    });
  }
}
