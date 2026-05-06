import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;
import '../controller/Home_controller.dart' show HomeController;

class OpponentTeamSelected extends StatelessWidget {
  const OpponentTeamSelected({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xFF78828A)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              homeController.selectedTeam.value,
              style: globalTextStyle(
                color: Color(0xFF082B09),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) {
                homeController.selectedTeam.value = value;
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'FCB',
                    child: Text(
                      'FCB',
                      style: globalTextStyle(
                        color: Color(0xFF082B09),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Real Madrid',
                    child: Text(
                      'Real Madrid',
                      style: globalTextStyle(
                        color: Color(0xFF082B09),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Bayern Munich',
                    child: Text(
                      'Bayern Munich',
                      style: globalTextStyle(
                        color: Color(0xFF082B09),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ];
              },
              icon: Image.asset(IconPath.dropdown, height: 32, width: 32),
            ),
          ],
        ),
      ),
    );
  }
}
