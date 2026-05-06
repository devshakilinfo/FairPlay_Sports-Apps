import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

import '../../games_setup/model/last_match_response.dart';

Row result(LastMatch? lastMatch) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        (lastMatch?.totalGoals ?? 0) > (lastMatch?.opponentGoals ?? 0)
            ? 'Win'
            : 'Loss',
        style: globalTextStyle(
          color: Color(0xff0047AB),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        'Result',
        style: globalTextStyle(
          color: Color(0xff565656),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        (lastMatch?.opponentGoals ?? 0) > (lastMatch?.totalGoals ?? 0)
            ? 'Win'
            : 'Loss',
        style: globalTextStyle(
          color: Color(0xff0047AB),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
