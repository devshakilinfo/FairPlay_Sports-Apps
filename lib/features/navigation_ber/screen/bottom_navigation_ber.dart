import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/games_screen/games_screen.dart';
import 'package:sports_apps/features/reports_screen/screens/report_screen.dart';

import '../../home/screen/home_screen.dart' show HomeScreen;
import '../../settings/screen/setting_screen.dart';
import '../controller/navigation_ber_controller.dart'
    show BottomNavbarController;

// ignore: must_be_immutable
class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});
  final BottomNavbarController controller = Get.put(BottomNavbarController());
  final List<Widget> pages = [
    HomeScreen(),
    GamesScreen(),
    ReportScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, -0),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                passiveImage: IconPath.disablehome,
                activeImage: IconPath.activehome,
                index: 0,
              ),
              _buildNavItem(
                passiveImage: IconPath.disablegame,
                activeImage: IconPath.activegame,
                index: 1,
              ),
              _buildNavItem(
                passiveImage: IconPath.disablereport,
                activeImage: IconPath.activereport,
                index: 2,
              ),
              _buildNavItem(
                passiveImage: IconPath.disablesetting,
                activeImage: IconPath.activesetting,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: 60,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
