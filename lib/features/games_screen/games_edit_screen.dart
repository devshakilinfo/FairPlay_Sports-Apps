import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/games_screen/games_controller/edit_screen_controller.dart';
import 'package:sports_apps/features/games_screen/games_controller/recent_action_controller.dart';

import '../home/screen/games_lineup/model/match_new_model.dart';

// ignore: must_be_immutable
class GamesEditScreen extends StatelessWidget {
  final MatchNewModel? matchData;
  GamesEditScreen({super.key, this.matchData});
  final RecentActionsController controller = Get.put(RecentActionsController());
  final TextEditingController timeController = TextEditingController();

  EditScreenController editScreenController = Get.put(EditScreenController());
  String? selectedPlayerId;
  String? gogleAssets;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double textFontSize = (screenHeight < 700) ? 10 : 12;

    // Assuming matchData.date is a string, parse it into DateTime.
    DateTime matchDate = DateTime.parse(matchData?.date.toString() ?? "");
    // Format the matchDate using '14 Feb 3:00 PM' or 'AM' format
    String dateAndTime = DateFormat('d MMM h:mm a').format(matchDate);
    editScreenController.setMatchId(matchData?.id ?? "");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 238,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 20,
                              width: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xffE6F8E7),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      size: 9,
                                      color: Color(0xff00BA0B),
                                    ),
                                    Text(
                                      "Edit",
                                      style: globalTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff00BA0B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 79,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 87,
                              height: 79,

                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 54,
                                    child:
                                        matchData?.logoUrl == null
                                            ? Image.asset(
                                              IconPath.cbflogo,
                                              width: 24,
                                              height: 32.26,
                                            )
                                            : ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.network(
                                                matchData?.logoUrl ?? "",
                                                width: 24,
                                                height: 32.26,
                                              ),
                                            ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      matchData?.clubName ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: globalTextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 63,
                              width: 63,

                              child: Column(
                                children: [
                                  Text(
                                    "${matchData!.totalGoals.toString()}-${matchData!.opponentGoals.toString()}",
                                    style: globalTextStyle(
                                      color: Color(0xff0047AB),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  Container(
                                    height: 22,
                                    width: 63,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Color(0xffE6F8E7),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${matchData!.duration.toString()} Min",
                                        style: globalTextStyle(
                                          color: Color(0xff00BA0B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 79,
                              width: 87,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 42,
                                      child:
                                          matchData?.logoUrl == null
                                              ? Image.asset(
                                                IconPath.cbflogo,
                                                width: 24,
                                                height: 32.26,
                                              )
                                              : ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.network(
                                                  matchData?.logoUrl ?? "",
                                                  width: 24,
                                                  height: 32.26,
                                                ),
                                              ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        matchData?.opponentTeam ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: globalTextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        indent: 15,
                        endIndent: 15,
                        color: Color(0xffE6EDF7),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 67,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vini Jr 8', 65'",
                                    style: globalTextStyle(
                                      color: Color(0xff898989),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Mbappe 45'",
                                    style: globalTextStyle(
                                      color: Color(0xff898989),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Belingham 78'",
                                    style: globalTextStyle(
                                      color: Color(0xff898989),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Y. Asprilla 34'",
                                    style: globalTextStyle(
                                      color: Color(0xff898989),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "A. Ruiz 83'",
                                    style: globalTextStyle(
                                      color: Color(0xff898989),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 17,
                          width: 108,
                          child: Text(
                            dateAndTime,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff565656),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "My Team",
                      style: TextStyle(
                        color: Color(0xff082B09),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Player',
                            style: globalTextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Color(0xFF78828A)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Text(
                                      editScreenController.selectedPlayer.value,
                                      style: globalTextStyle(
                                        color: Color(0xFFABABAB),
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  // PopupMenuButton to select a player
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: 32,
                                      width: 32,
                                    ),
                                    onSelected: (String value) {
                                      // Find the player by name
                                      Players selectedPlayer =
                                          editScreenController.players
                                              .firstWhere(
                                                (player) =>
                                                    player.name == value,
                                              );

                                      // Set the selected player name in the controller
                                      editScreenController.setSelectedPlayer(
                                        value,
                                      );
                                      editScreenController.setPlayerId(
                                        selectedPlayer.id,
                                      );

                                      // Print the selected player's id and name

                                      selectedPlayerId = selectedPlayer.id;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      // Mapping the players list to PopupMenuItems
                                      return editScreenController.players
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                            int index =
                                                entry
                                                    .key; // Get the index (key)
                                            Players player =
                                                entry
                                                    .value; // Get the player (value)

                                            return PopupMenuItem<String>(
                                              value:
                                                  player
                                                      .name, // Set the player's name as the value
                                              child: Text(
                                                player.name,
                                              ), // Display index and player name
                                            );
                                          })
                                          .toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Action',

                            style: globalTextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Color(0xFF78828A)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Text(
                                      editScreenController.selectedAction.value,
                                      style: globalTextStyle(
                                        color: Color(0xFFABABAB),
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  // PopupMenuButton to select action
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: 32,
                                      width: 32,
                                    ),
                                    onSelected: (String value) {
                                      // Update the selected action when a menu item is selected
                                      editScreenController.setAction(value);
                                      editScreenController.setGoalsAssets(
                                        value,
                                      );
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'goals',
                                          child: Text('Goal'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'assists',
                                          child: Text('Assist'),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00BA0B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {
                      // Check if loading is in progress
                      if (editScreenController.isLoading.value) return;

                      bool success =
                          await editScreenController.createPlayersStates();

                      if (success) {
                        Get.snackbar("Success", "Action added successfully");
                      } else {
                        // Handle error
                        Get.snackbar("Failed", "Failed to add action");
                      }
                    },
                    child: Obx(() {
                      // Display a loading spinner when the request is in progress
                      if (editScreenController.isLoading.value) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        );
                      } else {
                        return Text(
                          'Add Action',
                          style: globalTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        );
                      }
                    }),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Action",
                      style: globalTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff082B09),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() {
                  return ListView.builder(
                    itemCount: controller.recentActions.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final action = controller.recentActions[index];
                      return Column(
                        children: [
                          Container(
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        action.playerName,
                                        style: globalTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff082B09),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffE6EDF7),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            height: 22,
                                            width: 44,
                                            child: Center(
                                              child: Text(
                                                action.action,
                                                style: globalTextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff0047AB),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text("23'"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.removeAction(action);
                                          },
                                          child: Image.asset(IconPath.close),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    },
                  );
                }),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Final Score",
                        style: globalTextStyle(
                          color: Color(0xff082B09),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Team",
                                style: globalTextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              AuthCustomTextField(
                                controller: TextEditingController(),
                                text: 'Input Score',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Oponent Team",
                                style: globalTextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              AuthCustomTextField(
                                controller: TextEditingController(),
                                text: "Input Score",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00BA0B),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
