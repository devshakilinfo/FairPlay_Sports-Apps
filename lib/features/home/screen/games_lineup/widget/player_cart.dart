import 'package:flutter/material.dart';

import '../../../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../../../core/utils/constants/icon_path.dart' show IconPath;

class ProfileCart2 extends StatelessWidget {
  const ProfileCart2({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0047AB),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Image.asset(IconPath.clublogo),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alice Erksen',
                    style: globalTextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Real Madrid',
                    style: globalTextStyle(
                      color: Color(0xFF565656),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age',
                    style: globalTextStyle(
                      color: Color(0xFF898989),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '12 Year',
                    style: globalTextStyle(
                      color: Color(0xFF1F1F1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Position',
                    style: globalTextStyle(
                      color: Color(0xFF898989),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Center Forward',
                    style: globalTextStyle(
                      color: Color(0xFF1F1F1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Strong Foot',
                style: globalTextStyle(
                  color: Color(0xFF898989),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Left',
                style: globalTextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
