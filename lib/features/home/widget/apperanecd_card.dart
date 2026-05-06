import 'package:flutter/material.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;

class AppearanceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String count;

  const AppearanceCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = (screenHeight <700) ? 8 : 11;
    double fontSizeDown = (screenHeight <700) ? 13 : 16;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE6F8E7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: globalTextStyle(
                color: const Color(0xFF0047AB),
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 24, width: 24),
                SizedBox(width: 8),
                Text(
                  count,
                  style: globalTextStyle(
                    color: const Color(0xFF0047AB),
                    fontSize: fontSizeDown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
