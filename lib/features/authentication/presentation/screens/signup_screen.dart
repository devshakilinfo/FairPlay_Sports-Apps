import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/routes/app_routes.dart';

import '../../../../core/custom_widget/authe_custom_text_feild.dart';
import '../../controllers/singup_controller.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  SingupController singupController = Get.put(SingupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Sign Up',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Name',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                text: 'Enter your Name',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                controller: singupController.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Phone Number',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                controller: singupController.phoneController,
                text: 'Enter Phone e.g:+8801234567891',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Phone Number e.g:+8801234567891';
                  }
                  RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Invalid phone number format. Use +8801XXXXXXXXX';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Email',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                controller: singupController.emailController,
                text: 'Enter your valid Email',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email address';
                  }

                  RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format. Example: example@mail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Password',
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => AuthCustomTextField(
                  text: 'Must be at least 8 characters',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  controller: singupController.passwordController,
                  obscureText: singupController.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xFF00BA0B),
                    ),
                    onPressed: singupController.togglePasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Retype Password',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => AuthCustomTextField(
                  controller: singupController.retypepasswordController,
                  text: 'Must be at least 8 characters',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  obscureText: singupController.isPasswordVisible1.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible1.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xFF00BA0B),
                    ),
                    onPressed: singupController.togglePasswordVisibility1,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != singupController.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  title: 'Sign Up',
                  textcolor:
                      singupController.isFromValid.value
                          ? Colors.white
                          : Color(0xFF7EE07E),
                  onPress:
                      singupController.isFromValid.value
                          ? () {
                            singupController.signup();
                          }
                          : null,
                  backgroundColor:
                      singupController.isFromValid.value
                          ? Color(0xFF00BA0B)
                          : Color(0xFFE6F8E7),
                  borderColor:
                      singupController.isFromValid.value
                          ? Color(0xFF00BA0B)
                          : Color(0xFFE6F8E7),
                ),
              ),
              SizedBox(height: 28),
              // CustomDivider(),
              SizedBox(height: 32),
              if (Platform.isAndroid || Platform.isIOS) ...[
                // GestureDetector(
                //   onTap: () {
                //     //
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 8),
                //     decoration: BoxDecoration(
                //       color: Color(0XFF5384EE),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(IconPath.google, width: 24, height: 24),
                //         SizedBox(width: 12),
                //         Text(
                //           "Continue with Google",
                //           style: globalTextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
              SizedBox(height: 16),
              if (Platform.isIOS) ...[
                // GestureDetector(
                //   onTap: () {
                //     //
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 8),
                //     decoration: BoxDecoration(
                //       color: Colors.black,
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(IconPath.apple, width: 24, height: 24),
                //         SizedBox(width: 12),
                //         Text(
                //           "Continue with Apple",
                //           style: globalTextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.loginScreen);
                    },
                    child: Text(
                      "Sign In",
                      style: globalTextStyle(
                        color: Color(0xFF00BA0B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
