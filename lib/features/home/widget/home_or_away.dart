import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        PopupMenuButton,
        PopupMenuItem,
        StatelessWidget,
        Widget;
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart';
import '../controller/Home_controller.dart';

class HomeORaWay extends StatelessWidget {
  const HomeORaWay({super.key, required this.homeController});

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
              homeController.homeorAway.value,
              style: globalTextStyle(
                color: Color(0xFF082B09),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) {
                homeController.homeorAway.value = value;
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Home',
                    child: Text(
                      'Home',
                      style: globalTextStyle(
                        color: Color(0xFF082B09),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Away',
                    child: Text(
                      'Away',
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
