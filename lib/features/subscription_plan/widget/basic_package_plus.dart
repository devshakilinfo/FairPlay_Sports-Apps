import 'package:flutter/material.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class BasicPackagePlus extends StatelessWidget {
  const BasicPackagePlus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(IconPath.chack, height: 22, width: 22),
            SizedBox(width: 12),
            Text(
              'Fairness Calculator',
              style: globalTextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Image.asset(IconPath.chack, height: 22, width: 22),
            SizedBox(width: 12),
            Text(
              'Squad Time Rotation',
              style: globalTextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Image.asset(IconPath.not, height: 22, width: 22),
            SizedBox(width: 12),
            Text(
              'Squad Position Rotation',
              style: globalTextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Image.asset(IconPath.not, height: 22, width: 22),
            SizedBox(width: 12),
            Text(
              'Squad Analytics',
              style: globalTextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
