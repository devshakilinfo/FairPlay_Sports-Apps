import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

class PlayerRow extends StatelessWidget {
  final String playerName;
  final String duration;
  final String additionalInfo;

  const PlayerRow({
    super.key,
    required this.playerName,
    required this.duration,
    required this.additionalInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFE6EDF7)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            playerName,
            style: globalTextStyle(
              color: Color(0xFF565656),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFE6EDF7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text(
                  duration,
                  style: globalTextStyle(
                    color: Color(0xFF0047AB),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Image.asset(IconPath.editroad, height: 16, width: 16),
              ],
            ),
          ),
          Text(
            additionalInfo,
            style: globalTextStyle(
              color: Color(0xFF00BA0B),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
