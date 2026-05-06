import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enable;
  final String text;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.enable,
    required this.text,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 61,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xffE6EDF7), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 9.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 22,
              child: Text(
                text,
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff565656),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 18,
              child: TextField(
                controller: controller,
                enabled: enable,
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,

                  hintStyle: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 0, bottom: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
