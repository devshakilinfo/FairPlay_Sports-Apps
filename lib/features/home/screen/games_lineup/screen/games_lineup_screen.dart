import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/routes/app_routes.dart';
import '../controller/games_linup_controller.dart' show GamesLinupController;

// ignore: must_be_immutable
class GamesLineupScreen extends StatelessWidget {
  GamesLineupScreen({super.key});
  GamesLinupController gamesLinupController = Get.put(GamesLinupController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scaledWidth = (screenHeight < 700) ? 20 : 40;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Games Lineup',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (gamesLinupController.matches.isEmpty) {
            EasyLoading.show(
              status: "Loading...",
            ); // Show EasyLoading indicator when no data is available
            return SizedBox.shrink(); // Return an empty box while the loading indicator is shown
          } else {
            EasyLoading.dismiss(); // Dismiss the loading indicator once data is loaded
            return Column(
              children: [
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: gamesLinupController.matches.length,
                    itemBuilder: (context, index) {
                      final match = gamesLinupController.matches[index];
                      final remainingTime =
                          gamesLinupController.countdowns[index].value;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Color(0xFFE6EDF7)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox.shrink(),
                                  Text(
                                    'Next Match Preparation',
                                    style: globalTextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 53,
                                        width: 40,
                                        child:
                                            match.team1Logo.isNotEmpty
                                                ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    match.team1Logo,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                                : Image.asset(
                                                  IconPath.clublogo,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                      SizedBox(height: 8),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          match.team1Name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: globalTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF565656),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: scaledWidth),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        IconPath.activeVs,
                                        height: 38,
                                        width: 63,
                                      ),
                                      SizedBox(height: 16),
                                      Column(
                                        children: [
                                          Text(
                                            match.date,
                                            style: globalTextStyle(
                                              color: Color(0xFF565656),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            match.time,
                                            style: globalTextStyle(
                                              color: Color(0xFF565656),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: scaledWidth),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 53,
                                        width: 40,
                                        child:
                                            match.team2Name.isEmpty
                                                ? Image.asset(
                                                  IconPath.cbflogo,
                                                  fit: BoxFit.cover,
                                                )
                                                : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    match.team2Logo,
                                                    fit: BoxFit.cover,
                                                    width: 20,
                                                  ),
                                                ),
                                      ),
                                      SizedBox(height: 8),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          match.team2Name,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: globalTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF565656),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTimeBox(
                                    remainingTime.inDays.toString(),
                                    'Days',
                                  ),
                                  SizedBox(width: 8),
                                  _buildTimeBox(
                                    (remainingTime.inHours % 24).toString(),
                                    'Hours',
                                  ),
                                  SizedBox(width: 8),
                                  _buildTimeBox(
                                    (remainingTime.inMinutes % 60).toString(),
                                    'Min',
                                  ),
                                  SizedBox(width: 8),
                                  _buildTimeBox(
                                    (remainingTime.inSeconds % 60).toString(),
                                    'Sec',
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              CustomButton(
                                title: 'Manage Lineup',
                                onPress: () {
                                  Get.toNamed(AppRoute.gamesLineup2);
                                },
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildTimeBox(String time, String label) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Container(
        key: ValueKey<String>(time),
        height: 60,
        width: 55,
        decoration: BoxDecoration(
          color: Color(0xFFE6EDF7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,

              style: globalTextStyle(
                color: Color(0xFF0047AB),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: globalTextStyle(
                color: Color(0xFF0047AB),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
