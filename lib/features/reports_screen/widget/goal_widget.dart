import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

import '../../games_setup/model/last_match_response.dart';

Row goal(LastMatch? lastMatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        '${lastMatch?.totalGoals}',
        style: globalTextStyle(
          color: Color(0xff0047AB),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        'Goal',
        style: globalTextStyle(
          color: Color(0xff565656),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        '${lastMatch?.opponentGoals}',
        style: globalTextStyle(
          color: Color(0xff0047AB),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
