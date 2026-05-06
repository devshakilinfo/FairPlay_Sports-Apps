import 'package:flutter/material.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class CustomContainer extends StatelessWidget {
  final String text;
  const CustomContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF78828A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: globalTextStyle(
              color: Color(0xFF082B09),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(IconPath.dropdown, height: 32, width: 32),
        ],
      ),
    );
  }
}
