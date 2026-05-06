import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/routes/app_routes.dart';

import '../../../core/utils/constants/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(ImagePath.welcome, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  title: 'Log In',
                  onPress: () {
                    Get.toNamed(AppRoute.loginScreen);
                  },
                ),
                SizedBox(height: 16),
                CustomButton(
                  title: 'Sign Up',
                  onPress: () {
                    Get.toNamed(AppRoute.signupScreen);
                  },
                  textcolor: AppColors.buttoncolor,
                  backgroundColor: Colors.transparent,
                ),
                // SizedBox(height: 16),
                // RichText(
                //   text: TextSpan(
                //     text: 'Continue As Guest',
                //     style: GoogleFonts.montserrat(
                //       color: Colors.white,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       decoration: TextDecoration.underline,
                //       decorationColor: Colors.white,
                //     ),
                //   ),
                // ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
