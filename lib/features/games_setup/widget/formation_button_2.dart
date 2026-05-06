import 'package:flutter/material.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class FormationButtonRow2 extends StatelessWidget {
  const FormationButtonRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFFABABAB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '4-4-2',
                  style: globalTextStyle(
                    color: Color(0xFFABABAB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  IconPath.dropdown,
                  height: 32,
                  width: 32,
                  color: Color(0xFFABABAB),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFABABAB),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconPath.editroad,
                  height: 20,
                  width: 20,
                  color: Color(0xFFEBEBEB),
                ),
                SizedBox(width: 5),
                Text(
                  'Custome',
                  style: globalTextStyle(
                    color: Color(0xFFEBEBEB),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
