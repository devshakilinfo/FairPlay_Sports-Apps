import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/features/subscription_plan/model/all_plan.dart';
import 'package:sports_apps/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptioPlanController extends GetxController {
  var isselected = 'Basic'.obs;
  var isMonthlySelected = true.obs;
  var isYearlySelected = false.obs;
  var sessionId = ''.obs; // Holds the session ID after purchase
  var isPaymentInProgress = false.obs; // To track if payment is in progress

  var allplanList = <Plans>[].obs;

  void selectMonthly() {
    isMonthlySelected.value = true;
    isYearlySelected.value = false;
  }

  void selectYearly() {
    isMonthlySelected.value = false;
    isYearlySelected.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    getAllPlan();
  }

  // Fetch all subscription plans from the API
  Future<void> getAllPlan() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await http.get(
        Uri.parse(Urls.allPlan),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final AllPlan fetchedData = AllPlan.fromJson(decodedJson);
        allplanList.clear();
        allplanList.addAll(fetchedData.plans!);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      debugPrint('An error occurred while fetching plans: $e');
    }
  }

  // Method to launch the URL in the browser
  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Purchase Plan - Send POST request to purchase the subscription and get the checkout URL
  Future<void> purchasePlan(String planId, String subscriptionType) async {
    String duration = subscriptionType == 'Monthly' ? 'monthly' : 'yearly';

    final String url =
        '${Urls.purchasePlan}/$planId';

    final Map<String, dynamic> body = {'currency': 'usd', 'duration': duration};

    EasyLoading.show(status: 'Processing...');
    isPaymentInProgress.value = true; // Set payment in progress

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError("Authentication token is missing");
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final String checkoutUrl = responseBody['url'];

        String sessionId = _extractSessionIdFromUrl(checkoutUrl);

        if (sessionId.isNotEmpty) {
          this.sessionId.value = sessionId;
        }

        _launchURL(checkoutUrl);
      } else {
        EasyLoading.showError('Error: ${response.body}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('An error occurred');
    }
  }

  // Extract session ID from the URL
  String _extractSessionIdFromUrl(String url) {
    RegExp regExp = RegExp(r"cs_test_[a-zA-Z0-9]+");
    var match = regExp.firstMatch(url);
    return match?.group(0) ?? '';
  }

  // Verify payment by sending the session ID to the verification API
  Future<void> verifyPayment(String sessionId) async {
    final String apiUrl = '${Urls.verifyPayment}$sessionId';

    try {
      EasyLoading.show(status: 'Verifying payment...');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Payment verified successfully!');
        isPaymentInProgress.value = false;  // Reset payment progress
        Get.toNamed(AppRoute.profileScreen);
      } else {
        EasyLoading.showError('Payment verification failed');
      }
    } catch (e) {
      EasyLoading.showError('Error occurred while verifying payment');
    } finally {
      EasyLoading.dismiss();
    }
  }
}

