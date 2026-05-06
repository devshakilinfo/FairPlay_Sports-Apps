import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/features/authentication/presentation/screens/changed_password.dart';
import 'package:sports_apps/features/subscription_plan/screen/subscription_plan_screen.dart';
import 'package:sports_apps/routes/app_routes.dart';

class SingupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isPasswordVisible1 = false.obs;
  void togglePasswordVisibility1() {
    isPasswordVisible1.value = !isPasswordVisible1.value;
  }

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        retypepasswordController.text.isNotEmpty;
  }

  var isFormValid2 = false.obs;
  void validdateForm2() {
    isFormValid2.value = pinController.text.length == 6;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   pinController.dispose();
  // }

  Future<void> signup() async {
    EasyLoading.show(status: 'Signing up...');
    try {
      Map<String, dynamic> requestBody = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'confirmPassword': retypepasswordController.text.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 201) {
        Get.toNamed(AppRoute.otpSendScreen, arguments: emailController.text);
        EasyLoading.showSuccess("Registration Successful");
        debugPrint("===============2${response.body}");
        final responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', responseData["accessToken"]);
      } else {
        final responseData = jsonDecode(response.body);

        EasyLoading.showError(responseData["message"]);
      }
    } catch (e) {
      EasyLoading.showError("An error occurred");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    retypepasswordController.clear();
  }

  var pin = ''.obs;
  var errorColor = false.obs;

  void validatePin1(String? email) async {
    debugPrint("Parsing email: $email");

    try {
      EasyLoading.show(status: 'Verifying OTP...');

      String otp = pinController.text.trim();
      debugPrint("User input OTP: $otp");

      // Check if OTP is empty or invalid
      if (otp.isEmpty) {
        EasyLoading.showError("Please enter a valid OTP.");
        return;
      }

      Map<String, String> requestbody = {"otp": otp};

      final response = await http.post(
        Uri.parse(Urls.forgateOtpVerifyConfirm(email)),
        // headers: {"Authorization": 'Bearer $accessToken'},  // Ensure proper bearer token format
        body: requestbody,
      );

      debugPrint('Response Body: ${response.body}');
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('OTP Verified Successfully');
        // Navigate to the next screen on success
        debugPrint('OTP Verified Successfully: ${response.body}');
        Get.to(SubscriptionPlanScreen());
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


  // void validatePin1(String? email) async {
  //   debugPrint("Parsing email: $email");

  //   try {
  //     EasyLoading.show(status: 'Verifying OTP...');

  //     String otp = pinController.text.trim();
  //     debugPrint("User input OTP: $otp");

  //     // Check if OTP is empty or invalid
  //     if (otp.isEmpty) {
  //       EasyLoading.showError("Please enter a valid OTP.");
  //       return;
  //     }

  //     Map<String, String> requestbody = {"otp": otp};

  //     final response = await http.post(
  //       Uri.parse(Urls.forgateOtpVerifyConfirm(email)),
  //       // headers: {"Authorization": 'Bearer $accessToken'},  // Ensure proper bearer token format
  //       body: requestbody,
  //     );

  //     debugPrint('Response Body: ${response.body}');
  //     debugPrint("Status Code: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess('OTP Verified Successfully');
  //       // Navigate to the next screen on success
  //       debugPrint('OTP Verified Successfully: ${response.body}');
  //       Get.to(ChangedPassword(email: email));
  //     } else {
  //       var responseData = jsonDecode(response.body);
  //       var errorMessage = responseData['message'] ?? 'An error occurred';

  //       if (errorMessage.contains('Invalid or expired OTP')) {
  //         errorColor.value = true;
  //         EasyLoading.showError("Invalid or expired OTP. Please try again.");
  //       } else {
  //         EasyLoading.showError(errorMessage);
  //       }
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Something went wrong: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
