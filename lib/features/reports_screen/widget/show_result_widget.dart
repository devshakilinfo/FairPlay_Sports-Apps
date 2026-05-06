import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

import '../../games_setup/model/last_match_response.dart';

Row showresult(LastMatch? lastMatch) {
  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                lastMatch?.logoUrl ?? IconPath.teamsrm,
                height: 32.26,
                width: 24,
              ),
              SizedBox(width: 4.0),
              Text(
                (lastMatch?.clubName ?? ''),
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
      Spacer(),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${lastMatch?.totalGoals} - ${lastMatch?.opponentGoals}',
            style: globalTextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            formatDate(lastMatch?.date),
            style: globalTextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      Spacer(),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  // (lastMatch?.opponentTeam ?? '').substring(0, 5),
                  lastMatch?.opponentTeam ?? '',
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Image.network(
                lastMatch?.logoUrl ?? IconPath.teamsrm,
                height: 32.26,
                width: 24,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
