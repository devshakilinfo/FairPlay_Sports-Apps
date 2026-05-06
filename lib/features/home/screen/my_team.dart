import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';

class MyTeam extends StatelessWidget {
  const MyTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Team',
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF082B09),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 35, right: 35, top: 40),
        child: Column(
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
                //
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
        ),
      ),
    );
  }
}
