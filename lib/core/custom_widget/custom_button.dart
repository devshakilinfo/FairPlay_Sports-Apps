import 'package:flutter/material.dart';
import 'package:sports_apps/core/utils/constants/colors.dart' show AppColors;

import '../style/globaltextstyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.buttoncolor,
    this.borderColor = AppColors.buttoncolor,
    this.textStyle,
    required this.onPress,
    this.textcolor = AppColors.backgroundColor,
  });
  final Color textcolor;
  final String title;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? backgroundColor),
            borderRadius: BorderRadius.circular(4),
            color: backgroundColor,
          ),
          child: Center(
            child: Text(
              title,
              style: globalTextStyle(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
