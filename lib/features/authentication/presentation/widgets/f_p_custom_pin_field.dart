import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart'
    show PinCodeFieldShape, PinCodeTextField, PinTheme;
import 'package:sports_apps/features/authentication/controllers/forgot_password_controller.dart';


// ignore: must_be_immutable
class CustomPinField1 extends StatelessWidget {
  final TextEditingController controller;
  ForgetPasswordController singupController = Get.put(ForgetPasswordController());
  CustomPinField1({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      length: 6,
      onChanged: (value) {
        controller.text = value;
        singupController.validdateForm2();
      },
      pinTheme: PinTheme(
        fieldHeight: 50,
        fieldWidth: 50,
        selectedBorderWidth: 1,
        selectedColor: Color(0xFF00BA0B),
        activeColor: Color(0xFFA7A7A7),
        inactiveColor: Color(0xFFEBFAEB),
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}