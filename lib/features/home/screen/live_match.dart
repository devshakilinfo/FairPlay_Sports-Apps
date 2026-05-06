import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';
import 'package:sports_apps/features/home/controller/progress_controller.dart';
import 'package:sports_apps/features/home/models/all_player_add_model.dart';
import 'package:sports_apps/features/home/models/live_match_recent_action_model.dart';
import 'package:sports_apps/features/home/widget/live_match_playing.dart';
import 'package:sports_apps/features/home/widget/live_match_widget.dart';

import '../../games_screen/games_controller/edit_screen_controller.dart';
import '../../user_profile/controller/live_match_controller.dart';

// ignore: must_be_immutable
class LiveMatch extends StatelessWidget {
  LiveMatch({super.key});
  final ProgressController controller = Get.put(ProgressController());
  HomeController homeController = Get.put(HomeController());
  final LiveMatchRecentActionsController liveController = Get.put(
    LiveMatchRecentActionsController(),
  );
  LiveMatchController liveMtachController = Get.put(LiveMatchController());
  EditScreenController editScreenController = Get.put(EditScreenController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double textFontSize = (screenHeight < 700) ? 10 : 12;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Live Match",
          style: globalTextStyle(
            color: Color(0xff082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body in a SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              livematch(textFontSize, liveMtachController: liveMtachController),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Playing",
                    style: globalTextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              Obx(() {
                // Filter active players by checking matchLineupPlayers != 'rest'
                List<LineupPlayers> activePlayers =
                    homeController.allpalyers
                        .where((player) => player.matchLineupPlayers != 'rest')
                        .toList();

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: activePlayers.length,
                  itemBuilder: (context, index) {
                    final player = activePlayers[index].player;
                    return SelectedPalyersCard1(
                      index: index,
                      name: player!.name ?? "",
                      position: player.position ?? "",
                    );
                  },
                );
              }),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    editScreenController.selectedPlayer.value !=
                                            'Select Player'
                                        ? editScreenController
                                            .selectedPlayer
                                            .value
                                        : "Select Player", // Default text when no player is selected
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
                                    IconPath
                                        .dropdown, // Replace with your dropdown icon path
                                    height: 32,
                                    width: 32,
                                  ),
                                  onSelected: (String value) {
                                    // Find the player by name
                                    Players selectedPlayer =
                                        editScreenController.players.firstWhere(
                                          (player) => player.name == value,
                                        );

                                    // If player is found, set the selected player name and ID in the controller
                                    if (selectedPlayer.name != 'Unknown') {
                                      editScreenController.setSelectedPlayer(
                                        value,
                                      ); // Set selected player name
                                      editScreenController.setPlayerId(
                                        selectedPlayer.id,
                                      ); // Set player ID


                                      // Optional: Print the selected player's id and name
                                      debugPrint(
                                        "Selected Player: ${selectedPlayer.name}, ID: ${selectedPlayer.id}",
                                      );
                                    } else {
                                      // Handle case where the player is not found (though it shouldn't happen if data is valid)
                                      Exception("Player not found");
                                    }

                                  },
                                  itemBuilder: (BuildContext context) {
                                    // Mapping the players list to PopupMenuItems
                                    return editScreenController.players
                                        .where(
                                          // Ensure we only have valid names (non-null)
                                          (player) => player.name.isNotEmpty,
                                        )
                                        .map((player) {
                                          return PopupMenuItem<String>(
                                            value:
                                                player
                                                    .name, // Pass player name as the value
                                            child: Text(
                                              player.name,
                                            ), // Display player name
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    editScreenController.setGoalsAssets(value);

                                    debugPrint(value);


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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () async {
                    // liveMtachController.goalsUpate(matchId: , playerId: playerId, goalsAssets: goalsAssets);

                    await liveMtachController.goalsUpate(
                      matchId: liveMtachController.getPlayerId().toString(),
                      playerId: editScreenController.playerId.value,
                      goalsAssets: editScreenController.goalsAssets.value,
                    );
                  },
                  child: Text(
                    'Add Action',
                    style: globalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Opponent Team",
                    style: globalTextStyle(
                      color: Color(0xffFF3B30),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF3B30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    final newAction = LiveMatchRecentAction(
                      playerName: "Opponent",
                      action: "Goal",
                      type: "Goal",
                    );
                    liveController.addAction(newAction);
                  },
                  child: Text("Add Goal"),
                ),
              ),
              // Recent Action Section
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
              // Use ListView.builder for recent actions
              Obx(() {
                return ListView.builder(
                  itemCount: liveController.recentActions.length,
                  shrinkWrap:
                      true, // Allow ListView to take only the space it needs
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  itemBuilder: (context, index) {
                    final action = liveController.recentActions[index];
                    return Column(
                      children: [
                        Container(
                          height: 63,
                          decoration: BoxDecoration(
                            color:
                                action.type == "Goal"
                                    // ignore: deprecated_member_use
                                    ? Color(0xffFF3B30).withOpacity(0.1)
                                    : Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    action.type == "Goal"
                                        ? SizedBox.shrink()
                                        : Text(
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
                                            color:
                                                action.type == "Goal"
                                                    ? Color(0xffE6EDF7)
                                                    : Color(0xffE6F8E7),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          height: 22,
                                          width: 44,
                                          child: Center(
                                            child: Text(
                                              action.action,
                                              style: globalTextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    action.type == "Goal"
                                                        ? Color(
                                                          0xff0047AB,
                                                        ) // Goal text color
                                                        : Color(
                                                          0xff1F1F1F,
                                                        ), // Other actions text color
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text("23'"), // Placeholder for time
                                        SizedBox(width: 5),
                                        action.type == "Goal"
                                            ? Container(
                                              height: 20,
                                              width: 61,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                  0xffff3b30,
                                                  // ignore: deprecated_member_use
                                                ).withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  action.playerName,
                                                  style: globalTextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFF3B30),
                                                  ),
                                                ),
                                              ),
                                            )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: GestureDetector(
                                        onTap: () {
                                          _showConfirmationDialog(
                                            context,
                                            action,
                                          );
                                        },
                                        child: Image.asset(IconPath.close),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                );
              }),
              SizedBox(height: 40),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff00BA0B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                  child: Text("Save Match Data"),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    LiveMatchRecentAction action,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Container(
            height: 204,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffFFFFFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to remove this action?',
                    style: globalTextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 44,
                        width: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff00BA0B),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: globalTextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Container(
                        height: 44,
                        width: 148,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xff00BA0B),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            liveController.removeAction(action);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Yes, remove',
                            style: globalTextStyle(
                              color: Color(0xff00BA0B),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
