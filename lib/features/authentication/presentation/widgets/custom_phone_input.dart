import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput(
      {super.key, required this.controller, required this.onPhoneChanged});
  final TextEditingController controller;
  final ValueChanged<String> onPhoneChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        // color: const Color(0xffA5A3A3).withOpacity(0.5),
        border: Border.all(
          color: const Color(0xffA7A7A7),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17),
      child: Center(
        child: IntlPhoneField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          showCursor: true,
          dropdownIconPosition: IconPosition.trailing,
          decoration: InputDecoration(
            hintText: "Phone Number",
            hintStyle: GoogleFonts.poppins(
              color: Color(0xffA7A7A7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            labelStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
          initialCountryCode: 'US',
          dropdownIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff414141),
          ),
          dropdownTextStyle: TextStyle(
            color: Color(0xff262626),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent),
          ),
          disableLengthCheck: true,
          onChanged: (phone) {
            onPhoneChanged(
                phone.completeNumber.isEmpty ? '' : phone.completeNumber);
          },
        ),
      ),
    );
  }
}
