import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

import '../controller/games_setup_controller.dart' show GamesSetupController;


class CalculateTime extends StatelessWidget {
  const CalculateTime({super.key});

  @override
  Widget build(BuildContext context) {
    GamesSetupController gamesSetupController = Get.put(GamesSetupController());

    // final List<GroupData> groups = [
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-1", "Player-8"],
    //       ["Player-2", "Player-9"],
    //       ["Player-3", "Player-10"],
    //       ["Player-4"],
    //     ],
    //     restplayers: [
    //       ["Player-1", "Player-8"],
    //       ["Player-2", "Player-9"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    //   GroupData(
    //     timeRange: "00-8.00 min",
    //     duration: "8 min",
    //     players: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //       ["Player-1", "Player-2"],
    //     ],
    //     restplayers: [
    //       ["Player-6", "Player-7"],
    //       ["Player-7", "Player-1"],
    //     ],
    //   ),
    // ];
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Game Setup',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calculated Result',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(IconPath.save, height: 20, width: 20),
                ],
              ),
              SizedBox(height: 24),

              Obx(() {
                if (gamesSetupController.newCalculateTime.isEmpty) {
                  return Center(child: Text('No Data Available'));
                }
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  childAspectRatio: 1.50,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final List<String> imageTextList = [
                    "Time",
                    "Duration",
                    "Active Players",
                    "Resting Players",
                  ];
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF0047AB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        imageTextList[index],
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
              }),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: gamesSetupController.newCalculateTime.length,
                itemBuilder: (context, index) {
                  final group = gamesSetupController.newCalculateTime[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 160,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE6F8E7),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    group.timeSegment ?? 'N/A',
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF565656),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 160,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE6F8E7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    group.duration ?? 'N/A',
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF565656),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 160,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE6F8E7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      group.activePlayers?.join(", ") ?? 'N/A',
                                      style: globalTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF565656),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFE6F8E7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    group.restingPlayers?.join(", ") ?? 'N/A',
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF565656),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24),
              // Text(
              //   'Time Allocation',
              //   style: globalTextStyle(
              //     color: Color(0xFF333333),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: 4),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: gamesSetupController.playerData.length,
              //   itemBuilder: (context, index) {
              //     final player = gamesSetupController.playerData[index];
              //     return Padding(
              //       padding: EdgeInsets.only(bottom: 4),
              //       child: PlayerRow(
              //         playerName: player["name"]!,
              //         duration: player["duration"]!,
              //         additionalInfo: player["info"]!,
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: 'Reset',
                      onPress: () {
                        Get.back();
                      },
                      backgroundColor: Colors.white,
                      textcolor: Color(0xFF00BA0B),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                         // Ensure we access the controller properly
            final controller = Get.find<GamesSetupController>();

            // Debugging log to ensure the function is being called
            debugPrint('Calling Save As from CalculateTime screen...');
            
            // Call the method to generate PDF
            controller.onSaveAsPressed();
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF00BA0B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(IconPath.saveas, height: 20, width: 20),
                            SizedBox(width: 10),
                      
                            Text(
                              'Save As',
                              style: globalTextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              //comment for premium
              //===================================================================================================

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Formation',
              //       style: globalTextStyle(
              //         color: Color(0xFFABABAB),
              //         fontSize: 20,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     SizedBox(width: 5),
              //     Image.asset(IconPath.lock1, height: 20, width: 20),
              //   ],
              // ),
              // SizedBox(height: 20),
              // FormationButtonRow(), // ======================================= formation button row
              // SizedBox(height: 20),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Image.asset(ImagePath.football, fit: BoxFit.cover),
              //     // Player 1
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'CF',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.055,
              //     ),
              //     // Player 2
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'RWF',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.105,
              //       right: MediaQuery.of(context).size.height * 0.04,
              //     ),
              //     // Player 3
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'LWF',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.105,
              //       left: MediaQuery.of(context).size.height * 0.04,
              //     ),
              //     // Player 4
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'AM',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.210,
              //     ),
              //     // Player 5
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'CM',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.310,
              //       left: MediaQuery.of(context).size.height * 0.07,
              //     ),
              //     // Player 6
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'CM',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       top: MediaQuery.of(context).size.height * 0.310,
              //       right: MediaQuery.of(context).size.height * 0.08,
              //     ),
              //     // Player 7
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'RB',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       bottom: MediaQuery.of(context).size.height * 0.190,
              //       right: MediaQuery.of(context).size.height * 0.03,
              //     ),
              //     // Player 8
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'LB',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       bottom: MediaQuery.of(context).size.height * 0.190,
              //       left: MediaQuery.of(context).size.height * 0.03,
              //     ),
              //     // Player 9
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'CM',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       bottom: MediaQuery.of(context).size.height * 0.160,
              //       left: MediaQuery.of(context).size.height * 0.12,
              //     ),
              //     // Player 10
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'CM',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       bottom: MediaQuery.of(context).size.height * 0.160,
              //       right: MediaQuery.of(context).size.height * 0.12,
              //     ),
              //     // Player 11
              //     PlayerSetupWidget(
              //       playerName: 'Robert',
              //       playerRole: 'GK',
              //       profileImagePath: IconPath.profile,
              //       onEditPressed: () {
              //         //
              //       },
              //       bottom: MediaQuery.of(context).size.height * 0.028,
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),
              // Text(
              //   'Player Rotation',
              //   style: globalTextStyle(
              //     color: Color(0xFFABABAB),
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: 16),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4),
              //     border: Border.all(color: Color(0xFFE6EDF7)),
              //   ),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: 3,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: EdgeInsets.only(bottom: 4),
              //         child: PlayerRotationRow(
              //           gamesSetupController: gamesSetupController,
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(height: 40),
              // Row(
              //   children: [
              //     Expanded(
              //       child: CustomButton(
              //         title: 'Reset',
              //         onPress: () {
              //           //
              //         },
              //         backgroundColor: Colors.white,
              //         textcolor: Color(0xFF00BA0B),
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: CustomButton(
              //         title: 'Save Changes',
              //         onPress: () {
              //           //
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),

              //===========================================================================
            ],
          ),
        ),
      ),
    );
  }
}
