import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/utils/constants/colors.dart';
import 'package:sports_apps/features/authentication/presentation/screens/forget_password.dart';
import '../../../../core/custom_widget/authe_custom_text_feild.dart';
import '../../../../core/custom_widget/custom_button.dart';
import '../../../../core/style/globaltextstyle.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Log In',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Text(
                //   'Log In',
                //   style: globalTextStyle(
                //     color: Color(0xFF082B09),
                //     fontSize: 24,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: globalTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  onChanged: (value) {
                    loginController.validateFrom();
                  },
                  controller: loginController.emailController,
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Incorrect email or password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: globalTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Obx(() {
                  return AuthCustomTextField(
                    onChanged: (value) {
                      loginController.validateFrom();
                    },
                    text: 'Enter your password',
                    controller: loginController.passwordControler,
                    obscureText: loginController.isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect email or password';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: 32),
                Obx(
                  () => CustomButton(
                    title: 'Log In',
                    textcolor:
                        loginController.isFromValid.value
                            ? Colors.white
                            : Color(0xFF7EE07E),
                    onPress: () {
                      if (_formKey.currentState!.validate() &&
                          loginController.isFromValid.value) {
                        loginController.login();
                      } else {
                        //
                      }
                    },
                    backgroundColor:
                        loginController.isFromValid.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
                    borderColor:
                        loginController.isFromValid.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: globalTextStyle(
                        color: Color(0xFF0047AB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
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
                        Get.toNamed(AppRoute.signupScreen);
                      },
                      child: Text(
                        "Sign Up",
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
      ),
    );
  }
}
