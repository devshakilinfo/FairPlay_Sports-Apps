import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/home/screen/static_game_lineup.dart';
import 'package:sports_apps/routes/app_routes.dart';

class ManageLineup extends StatelessWidget {
  const ManageLineup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lineup Management',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Get.toNamed(AppRoute.myTeam);
                // Get.toNamed(AppRoute.gamesLineup);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaticGameLineup()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF0047AB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'My Team',
                          style: globalTextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'View all your players in one \nplace, edit their details, and \ntrack their history',
                          style: globalTextStyle(
                            color: Color(0xFFE6EDF7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                      right: 4,
                      top: 14,
                      child: Image.asset(
                        ImagePath.player,
                        height: 132,
                        width: 125,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.gamesLineupScreen);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF00BA0B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Games Lineup',
                          style: globalTextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Set and manage lineup for \nindividual gmaes',
                          style: globalTextStyle(
                            color: Color(0xFFE6EDF7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Image.asset(
                        ImagePath.playstyle,
                        height: 150,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
