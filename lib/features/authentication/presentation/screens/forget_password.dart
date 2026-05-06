import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/features/authentication/controllers/forgot_password_controller.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);
  TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  final ForgetPasswordController forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff082B09),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 60),
            Center(
              child: Text(
                "Please Enter your email address or phone",
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5F5F5F),
                ),
              ),
            ),
            Center(
              child: Text(
                "number for confirmation code.",
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5F5F5F),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              height: 44,
              width: 190,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      focusedButtonIndex.value = 0;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 0
                                    ? Color(0xff00BA0B)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    value == 0
                                        ? Colors.white
                                        : Color(0xff082B09),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     focusedButtonIndex.value = 1;
                  //   },
                  //   child: ValueListenableBuilder<int>(
                  //     valueListenable: focusedButtonIndex,
                  //     builder: (context, value, child) {
                  //       return Container(
                  //         height: 44,
                  //         width: 93,
                  //         decoration: BoxDecoration(
                  //           color:
                  //               value == 1
                  //                   ? Color(0xff00BA0B)
                  //                   : Colors.transparent,
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             "Phone",
                  //             style: TextStyle(
                  //               fontSize: 12,
                  //               color:
                  //                   value == 1
                  //                       ? Colors.white
                  //                       : Color(0xff082B09),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 31),
            ValueListenableBuilder<int>(
              valueListenable: focusedButtonIndex,
              builder: (context, value, child) {
                return Column(
                  children: [
                    if (value == 0)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: globalTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            AuthCustomTextField(
                              controller: emailController,
                              text: "Enter your Email",
                            ),
                          ],
                        ),
                      ),
                    // if (value == 1)
                    //   Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Phone",
                    //               style: globalTextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: Color(0xff333333),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 8),
                    //         AuthCustomTextField(
                    //           controller: phoneController,
                    //           text: "Enter your phone number",
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                );
              },
            ),
            SizedBox(height: 63),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xff00BA0B),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      EasyLoading.showError('Please enter your email');
                    } else {
                      forgetPasswordController.emailController.value =
                          emailController.text;
                      forgetPasswordController.sendOtp(emailController.text);
                    }
                  },
                  child: Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
