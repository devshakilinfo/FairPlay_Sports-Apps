import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

import '../../controllers/singup_controller.dart';
import '../widgets/custom_pin.dart' show CustomPinField;

// ignore: must_be_immutable
class OtpSendScreen extends StatelessWidget {
  OtpSendScreen({super.key});
  SingupController singupController = Get.put(SingupController());

  @override
  Widget build(BuildContext context) {
    
    final String email = Get.arguments;
    debugPrint("persinge email: $email");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the\n confirmation code',
                  style: globalTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                CustomPinField(controller: singupController.pinController),
                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Verification code has been sent to the phone number Your ',
                        style: globalTextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '0724****',
                        style: globalTextStyle(
                          color: Color(0xFF00BA0B),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    //
                  },
                  child: Text(
                    "Resend Code",
                    style: globalTextStyle(
                      color: Color(0xFF0047AB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // Obx(
                //   () => CustomButton(
                //     title: 'Continue',
                //     textcolor:
                //         singupController.isFormValid2.value
                //             ? Colors.white
                //             : Color(0xFF7EE07E),
                //     onPress:
                //         singupController.isFormValid2.value
                //             ? () {
                //               Get.toNamed(AppRoute.subscriptionPlanScreen);
                //             }
                //             : null,
                //     backgroundColor:
                //         singupController.isFormValid2.value
                //             ? Color(0xFF00BA0B)
                //             : Color(0xFFE6F8E7),
                //     borderColor:
                //         singupController.isFormValid2.value
                //             ? Color(0xFF00BA0B)
                //             : Color(0xFFE6F8E7),
                //   ),
                // ),

                // Inside the OtpSendScreen widget
                Obx(
                  () => CustomButton(
                    title: 'Continue',
                    textcolor:
                        singupController.isFormValid2.value
                            ? Colors.white
                            : Color(0xFF7EE07E),
                    onPress:
                        singupController.isFormValid2.value
                            ? () {
                              // Call the validatePin method with the required parameters
                              singupController.validatePin1(email);
                            }
                            : null,
                    backgroundColor:
                        singupController.isFormValid2.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
                    borderColor:
                        singupController.isFormValid2.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
