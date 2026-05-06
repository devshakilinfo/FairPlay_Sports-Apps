import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/features/games_screen/games_controller/games_controller.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';

GamesController gamesController = Get.put(GamesController());
HomeController homeController = Get.put(HomeController());

Obx timecountdown() {
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(
          homeController.days.value.toString().padLeft(2, '0'),
          'Days',
          gamesController.timeTextColor.value,
        ),
        SizedBox(width: 8),
        _buildTimeBox(
          homeController.hours.value.toString().padLeft(2, '0'),
          'Hours',
          gamesController.timeTextColor.value,
        ),
        SizedBox(width: 8),
        _buildTimeBox(
          homeController.minutes.value.toString().padLeft(2, '0'),
          'Min',
          gamesController.timeTextColor.value,
        ),
        SizedBox(width: 8),
        _buildTimeBox(
          homeController.seconds.value.toString().padLeft(2, '0'),
          'Sec',
          gamesController.timeTextColor.value,
        ),
      ],
    ),
  );
}

Widget _buildTimeBox(String timeValue, String label, Color textColor) {
  return AnimatedSwitcher(
    duration: Duration(milliseconds: 500),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return FadeTransition(opacity: animation, child: child);
    },
    child: Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Color(0xFFE6EDF7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeValue,
            key: ValueKey<String>(timeValue),
            style: globalTextStyle(
              color: textColor, // Use the passed color
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: globalTextStyle(
              color: gamesController.timeTextColor.value,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
  );
}
