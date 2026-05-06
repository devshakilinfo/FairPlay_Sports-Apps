import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';

import '../widget/apperanecd_card.dart' show AppearanceCard;
import '../widget/match_card.dart' show MatchCard;
import '../widget/player_cart.dart' show ProfileCart;

// ignore: must_be_immutable
class PlayerHistory extends StatelessWidget {
  PlayerHistory({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        // title: Text(
        //   'Player History',
        //   style: globalTextStyle(
        //     color: Color(0xFF082B09),
        //     fontSize: 24,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
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
                  playername: "",
                  playerage: "",
                  playerposition: "",
                  playerstrongfoot: "",
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
                  count: '50',
                ),
                SizedBox(width: 12),
                AppearanceCard(
                  title: 'Goals',
                  imagePath: IconPath.goals,
                  count: '24',
                ),
                SizedBox(width: 12),
                AppearanceCard(
                  title: 'Assists',
                  imagePath: IconPath.assists,
                  count: '11',
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
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: MatchCard(
                        matchdate: '',
                        totalassists: '',
                        totalgoals: '',
                        minutes: '',
                        opponentteam: '',
                      ),
                    );
                  },
                ),
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
