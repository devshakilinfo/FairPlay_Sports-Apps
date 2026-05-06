import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';
import 'package:sports_apps/features/home/screen/games_lineup/controller/player_history2_controller.dart';

import '../../../widget/apperanecd_card.dart' show AppearanceCard;
import '../../../widget/match_card.dart' show MatchCard;
import '../../../widget/player_cart.dart' show ProfileCart;

// ignore: must_be_immutable
class PlayerHistory2 extends StatelessWidget {
  PlayerHistory2({super.key});

  HomeController homeController = Get.put(HomeController());
  PlayerHistory2Controller controller = Get.put(PlayerHistory2Controller());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    var index = arguments['index'];
    var status = arguments['status'];
    var filteredPlayers =
        homeController.allpalyers
            .where((player) => player.matchLineupPlayers == status)
            .toList();

    if (filteredPlayers.isNotEmpty && index < filteredPlayers.length) {
      debugPrint("Player ID: ${filteredPlayers[index].player?.id}");
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Player History',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get the player ID from the filtered list
              final playerId = filteredPlayers[index].player?.id;
              if (playerId != null) {
                controller.deletePlayer(playerId);
              } else {
                EasyLoading.showError("Player ID not found");
              }
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCart(
                  playername: filteredPlayers[index].player!.name ?? "",
                  playerage:
                      (DateTime.now().year -
                              (filteredPlayers[index].player!.birthYear ?? 0))
                          .toString(),

                  playerposition: filteredPlayers[index].player!.position ?? "",
                  playerstrongfoot:
                      filteredPlayers[index].player!.preferredFoot ?? "",
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    ImagePath.palyerimage,
                    width: 131,
                    height: 157,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                AppearanceCard(
                  title: 'Appearance',
                  imagePath: IconPath.appearance,
                  count: "50",
                ),
                SizedBox(width: 12),
                AppearanceCard(
                  title: 'Goals',
                  imagePath: IconPath.goals,
                  count: filteredPlayers[index].player!.totalGoals.toString(),
                ),
                SizedBox(width: 12),
                AppearanceCard(
                  title: 'Assists',
                  imagePath: IconPath.assists,
                  count: filteredPlayers[index].player!.totalAssists.toString(),
                ),
                SizedBox(width: 12),
                AppearanceCard(
                  title: 'Minutes',
                  imagePath: IconPath.watch,
                  count: '1342',
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Match History',
              style: globalTextStyle(
                color: Color(0xFF082B09),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount:
                    filteredPlayers[index].player?.matchStats?.length ?? 0,
                itemBuilder: (context, matchIndex) {
                  var player = filteredPlayers[index].player!;

                  var matchStat = player.matchStats![matchIndex];

                  var match = matchStat.match;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: MatchCard(
                      matchdate: match?.date ?? "",
                      minutes: match?.duration?.toString() ?? "0",
                      opponentteam: match?.opponentTeam ?? "",
                      totalgoals: matchStat.goals?.toString() ?? "0",
                      totalassists: matchStat.assists?.toString() ?? "0",
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF00BA0B),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IconPath.share, height: 20, width: 20),
                      SizedBox(width: 10),
                      Text(
                        "share",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
