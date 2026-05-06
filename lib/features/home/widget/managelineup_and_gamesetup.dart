import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/routes/app_routes.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;

// ignore: camel_case_types
class ManageLineup_GameSetup extends StatelessWidget {
  final String planName;

  const ManageLineup_GameSetup({super.key, required this.planName});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double textFontSize = (screenHeight < 700) ? 15 : 16;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              planName == "basic" ? null : Get.toNamed(AppRoute.manageLineup);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFFE6EDF7)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      planName == "basic"
                          ? Image.asset(IconPath.lock1, height: 20, width: 20)
                          : SizedBox(height: 20),
                    ],
                  ),
                  planName == "basic"
                      ? Image.asset(IconPath.kabaddi, height: 24, width: 24)
                      : Image.asset(
                        IconPath.activekabaddie,
                        height: 24,
                        width: 24,
                      ),
                  SizedBox(height: 4),
                  Text(
                    'Manage Lineup',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
               Get.toNamed(AppRoute.gamesSetup);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFFE6EDF7)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // planName == "basic"
                          // ? Image.asset(IconPath.lock1, height: 20, width: 20)
                          SizedBox(height: 20),
                    ],
                  ),
                      // ? Image.asset(IconPath.settings, height: 24, width: 24)
                       Image.asset(
                        IconPath.activesettings,
                        height: 24,
                        width: 24,
                      ),
                  SizedBox(height: 4),
                  Text(
                    'Game Setup',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
