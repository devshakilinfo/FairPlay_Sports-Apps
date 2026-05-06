import 'package:flutter/material.dart';

import '../style/globaltextstyle.dart' show globalTextStyle;

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width * 0.38,
          decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        ),
        Text(
          'or',
          style: globalTextStyle(
            color: Color(0xFF898989),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width * 0.38,
          decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
        ),
      ],
    );
  }
}
