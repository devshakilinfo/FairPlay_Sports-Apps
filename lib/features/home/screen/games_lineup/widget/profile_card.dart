import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';

class PlayerCard extends StatelessWidget {
  final String name;
  final String position;
  final int index;

  const PlayerCard({
    super.key,
    required this.name,
    required this.position,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Obx(() {
      // ignore: collection_methods_unrelated_type
      bool isSelected = homeController.selectedPlayers.contains(index);
      return GestureDetector(
        onTap: () {
          homeController.toggleSelection(index);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFE6F8E7) : Colors.white,
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
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 55,
                      child: Text(
                        name,
                        style: globalTextStyle(
                          color: Color(0xFF082B09),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    position,
                    style: globalTextStyle(
                      color: Color(0xFF00BA0B),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
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
