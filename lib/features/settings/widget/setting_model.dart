import 'package:flutter/widgets.dart';
import '../../../core/style/globaltextstyle.dart' show globalTextStyle;

class SettingModel extends StatelessWidget {
  final String imagePath;
  final String text;

  const SettingModel({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imagePath, height: 18, width: 18),
        SizedBox(width: 10),
        Text(
          text,
          style: globalTextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
