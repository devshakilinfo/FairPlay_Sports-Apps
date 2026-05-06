import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;
import '../controller/games_setup_controller.dart' show GamesSetupController;

class PlayerRotationRow extends StatelessWidget {
  const PlayerRotationRow({super.key, required this.gamesSetupController});

  final GamesSetupController gamesSetupController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFEBEBEB)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(IconPath.profile)),
              SizedBox(width: 4),
              Text(
                'Jane Cooper',
                style: globalTextStyle(
                  color: Color(0xFF082B09),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              decoration: BoxDecoration(
                color: Color(0xFFE6EDF7),
                border: Border.all(color: Color(0xFF0047AB)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      '${gamesSetupController.count.value}',
                      style: globalTextStyle(
                        color: Color(0xFF0047AB),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          gamesSetupController.increment();
                        },
                        child: Image.asset(IconPath.up, height: 10, width: 10),
                      ),
                      GestureDetector(
                        onTap: () {
                          gamesSetupController.decrement();
                        },
                        child: Image.asset(
                          IconPath.down,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
