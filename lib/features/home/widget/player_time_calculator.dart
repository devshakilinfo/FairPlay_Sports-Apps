import 'package:flutter/material.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart';

class PlayerTimeCalculator extends StatelessWidget {
  const PlayerTimeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 105,
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xFF0047AB),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 11,
            right: 36,
            child: Image.asset(IconPath.unsplash, height: 98, width: 148),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Equal Playing Time Calculator',
                    style: globalTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ensure fair play by calculating balanced \ngame time for all players.',
                    style: globalTextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(IconPath.decorative, height: 32, width: 32),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
