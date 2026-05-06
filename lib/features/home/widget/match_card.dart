import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';

// ignore: must_be_immutable
class MatchCard extends StatelessWidget {
  String matchdate;
  String opponentteam;
  String totalgoals;
  String totalassists;
  String minutes;
 MatchCard({super.key,
 required this.matchdate,
 required this.opponentteam,
 required this.totalgoals,
 required this.totalassists,
 required this.minutes
 });
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    DateTime matchDate = DateTime.parse(matchdate.toString() );
    // Format the matchDate using '14 Feb 3:00 PM' or 'AM' format
    String dateAndTime = DateFormat('d MMM, y').format(matchDate);



    var arguments = Get.arguments;
    var index = arguments['index'];
    var status=arguments['status'];

    var filteredPlayers =
            homeController.allpalyers
                .where((player) => player.matchLineupPlayers == status)
                .toList();

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE6EDF7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateAndTime,
                style: globalTextStyle(
                  color: Color(0xFF898989),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'VS $opponentteam',
                style: globalTextStyle(
                  color: Color(0xFF082B09),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Goals',
                style: globalTextStyle(
                  color: Color(0xFF898989),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                totalgoals,
                style: globalTextStyle(
                  color: Color(0xFF0047AB),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Assists',
                style: globalTextStyle(
                  color: Color(0xFF898989),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                totalassists,
                style: globalTextStyle(
                  color: Color(0xFF0047AB),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Minutes',
                style: globalTextStyle(
                  color: Color(0xFF898989),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                minutes,
                style: globalTextStyle(
                  color: Color(0xFF0047AB),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
