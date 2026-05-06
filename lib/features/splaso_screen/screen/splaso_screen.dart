import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/utils/constants/colors.dart';

import '../../../core/utils/constants/icon_path.dart';
import '../controller/splaso_screen_controller.dart'
    show SplashScreenController;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    var screenWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundColor,
      child: Center(
        child: Image.asset(IconPath.splaso, width: screenWidth * .7),
      ),
    );
  }
}
