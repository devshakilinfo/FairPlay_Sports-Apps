import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_apps/core/urls/endpoint.dart';
import 'dart:convert';

import 'package:sports_apps/routes/app_routes.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController pinController = TextEditingController();
  final emailController = ''.obs;
  final otpController = ''.obs;
  String storedEmail = '';

  Future<void> sendOtp(String email) async {
    try {
      EasyLoading.show(status: 'Sending OTP...');

      // Debugging the URL being used
      debugPrint(Urls.forgotPassword);

      // Make the POST request to the API
      final response = await http.post(
        Uri.parse(Urls.forgotPassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }), // Sending the email in the request body
      );

      debugPrint('API Response: ${response.body}');
      debugPrint('API Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];

        // Check if the response message matches "OTP sent successfully"
        if (message == "OTP sent successfully") {
          EasyLoading.showSuccess('OTP Sent Successfully');
          debugPrint("OTP sent: ${response.body}");

          // Store the email and navigate to the OTP verification screen
          storedEmail = email;
          Get.toNamed(
            AppRoute.otpSendScreen,
            arguments: email, // Pass the email as an argument
          );
        } else {
          // If message is not as expected, show an error
          EasyLoading.showError('Unexpected response message: $message');
        }
      } else if (response.statusCode == 502) {
        EasyLoading.showError('Server Error: Please try again later');
      } else {
        // Handle other errors
        final errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to Send OTP';
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      // Handle any unexpected errors during the request
      EasyLoading.showError('Error: $e');
    } finally {
      // Dismiss the loading indicator once the request is complete
      EasyLoading.dismiss();
    }
  }

  // //forget password otp verify

  var isFormValid2 = false.obs;

  void validdateForm2() {
    isFormValid2.value = pinController.text.length == 6;
  }
  //   Future<void> verifyOtp(String otp) async {
  //   try {
  //     if (storedEmail.isEmpty) {
  //       EasyLoading.showError('Email is missing. Please request an OTP first.');
  //       return;
  //     }

  //     EasyLoading.show(status: 'Verifying OTP...');

  //     // Debug: Print the OTP and stored email
  //     debugPrint('OTP: $otp');
  //     debugPrint('Stored Email: $storedEmail');

  //     // Replace with your OTP verification API
  //     final response = await http.post(
  //       Uri.parse('https://sports-app-dvka.onrender.com/auth/verify-otp'),
  //       body: {
  //         'email': storedEmail, // Use the stored email
  //         'otp': otp,
  //       },
  //     );

  //     // Debug: Print the API response status code and body
  //     debugPrint('Response Status Code: ${response.statusCode}');
  //     debugPrint('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess('OTP Verified Successfully');
  //       // Navigate to the next screen (e.g., reset password screen)
  //       Get.toNamed('/next-screen'); // Replace with your desired route
  //     } else {
  //       EasyLoading.showError('Invalid OTP: ${response.body}');
  //     }
  //   } catch (e) {
  //     EasyLoading.showError('Error: $e');
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  var errorColor = false.obs;
  void vefyOtp() async {
    try {
      EasyLoading.show(status: 'Verifying OTP...');

      Map<String, String> requestbody = {
        "email": emailController.trim(),
        "otp": pinController.text.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.verifyOtp),

        body: jsonEncode(requestbody),
      );

      debugPrint('///////////////////${response.body}');
      debugPrint("///////////////////${response.statusCode}");

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('OTP Verified Successfully');
        // Navigate to the next screen on success
        Get.toNamed(AppRoute.profileScreen);
      } else {
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'An error occurred';

        if (errorMessage.contains('Invalid or expired OTP')) {
          errorColor.value = true;
          EasyLoading.showError("Invalid or expired OTP. Please try again.");
        } else {
          EasyLoading.showError(errorMessage);
        }
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
