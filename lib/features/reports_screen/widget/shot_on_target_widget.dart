import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

Row shotontarget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          '11',
          style: globalTextStyle(
            color: Color(0xff0047AB),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Text(
        'Shots on Target',
        style: globalTextStyle(
          color: Color(0xff565656),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          '6',
          style: globalTextStyle(
            color: Color(0xff0047AB),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
