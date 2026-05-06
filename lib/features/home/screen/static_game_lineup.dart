import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/home/widget/static_player_card.dart';
import '../controller/Home_controller.dart' show HomeController;

// ignore: must_be_immutable
class StaticGameLineup extends StatelessWidget {
  StaticGameLineup({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Full Squad",
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                if (homeController.allpalyers.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.chackImage, fit: BoxFit.cover),
                      SizedBox(height: 12),
                      Text(
                        'No Player Data Yet',
                        style: globalTextStyle(
                          color: Color(0xFF565656),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'You need to add players to manage the lineup. Start by adding players to set up your team formation',
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF898989),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          homeController.showCustomDialog(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(IconPath.add1, height: 24, width: 24),
                            SizedBox(width: 12),
                            Text(
                              'Add Player',
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Players',
                        style: globalTextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2.2,
                            ),
                        itemCount: homeController.allpalyers.length,
                        //
                        itemBuilder: (context, index) {
                          return StaticPlayerCard(
                            index: index,
                            name:
                                homeController.allpalyers[index].player!.name ??
                                "name",
                            position:
                                homeController
                                    .allpalyers[index]
                                    .player!
                                    .position ??
                                "postion",
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Tap on players to select them for the game",
                        style: globalTextStyle(
                          color: Color(0xFF898989),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30),
                      // Text(
                      //   'Goalkeeper Fixed Position',
                      //   style: globalTextStyle(
                      //     color: Color(0xFF333333),
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(height: 12),
                      // Obx(() {
                      //   return Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Radio<String>(
                      //             value: 'Yes',
                      //             groupValue:
                      //                 homeController.selectedAnswer.value,
                      //             onChanged: (String? value) {
                      //               homeController.updateAnswer(value!);
                      //             },
                      //             activeColor: Color(0xFF00BA0B),
                      //           ),
                      //           Text(
                      //             'Yes',
                      //             style: globalTextStyle(
                      //               color: Color(0xFF565656),
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //           SizedBox(width: 23),
                      //           Radio<String>(
                      //             value: 'No',
                      //             groupValue:
                      //                 homeController.selectedAnswer.value,
                      //             onChanged: (String? value) {
                      //               homeController.updateAnswer(value!);
                      //             },
                      //             activeColor: Color(0xFF00BA0B),
                      //           ),
                      //           Text(
                      //             'No',
                      //             style: globalTextStyle(
                      //               color: Color(0xFF565656),
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   );
                      // }),
                      // SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          homeController.showCustomDialog(context);
                        },
                        child: Row(
                          children: [
                            Image.asset(IconPath.add1, height: 24, width: 24),
                            SizedBox(width: 6),
                            Text(
                              'Add Player',
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      // Obx(
                      //   () => CustomButton(
                      //     title:
                      //         homeController.isSaveButtonClicked.value
                      //             ? "Edit Lineup"
                      //             : 'Save Changes',
                      //     onPress:
                      //         homeController.isSaveButtonEnabled
                      //             ? () {
                      //               homeController.onSaveChangesClicked();
                      //             }
                      //             : null,
                      //     textcolor:
                      //         homeController.isSaveButtonEnabled
                      //             ? Colors.white
                      //             : Color(0xFF7EE07E),
                      //     backgroundColor:
                      //         homeController.isSaveButtonEnabled
                      //             ? Color(0xFF00BA0B)
                      //             : Color(0xFFE6F8E7),
                      //     borderColor:
                      //         homeController.isSaveButtonEnabled
                      //             ? Color(0xFF00BA0B)
                      //             : Color(0xFFE6F8E7),
                      //   ),
                      // ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
