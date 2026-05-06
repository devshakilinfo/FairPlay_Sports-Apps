import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';

class StaticPlayerCard extends StatelessWidget {
  final String name;
  final String position;
  final int index;

  const StaticPlayerCard({
    super.key,
    required this.name,
    required this.position,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = (screenHeight <700) ? 45: 55;
        double textFontSize = (screenHeight < 700) ? 10 : 12;
    return Obx(() {
      // ignore: collection_methods_unrelated_type
      homeController.selectedPlayers.contains(index);
      return GestureDetector(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: AssetImage(IconPath.playerprofile)),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: screenWidth,
                      child: Text(
                        name,
                        style: globalTextStyle(
                          color: Color(0xFF082B09),
                          fontSize: textFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: screenWidth,
                      child: Text(
                        position,
                        style: globalTextStyle(
                          color: Color(0xFF00BA0B),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}



