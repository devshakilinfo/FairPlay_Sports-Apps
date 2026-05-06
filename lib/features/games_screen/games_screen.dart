import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/games_screen/games_controller/games_controller.dart';
import 'package:sports_apps/features/games_screen/games_edit_screen.dart';
import 'package:sports_apps/features/games_screen/games_widget.dart/time_widget.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';
import 'package:sports_apps/features/home/widget/home_or_away.dart';
import 'package:sports_apps/features/home/widget/opponent_team_selected.dart';
import '../../core/utils/constants/image_path.dart';
import '../home/screen/games_lineup/controller/match_data_controller.dart';
import '../home/screen/games_lineup/model/match_new_model.dart';

// ignore: must_be_immutable
class GamesScreen extends StatelessWidget {
  GamesScreen({super.key});
  HomeController homeController = Get.put(HomeController());
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);
  GamesController gamesController = Get.put(GamesController());
  final containerColor = ValueNotifier<Color>(Color(0xffEBEBEB));
  final containerColor1 = ValueNotifier<Color>(Color(0xffABABAB));
  final ValueNotifier<bool> showNoMatchData = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    MatchDataController matchDataController = Get.put(MatchDataController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Games",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff082B09),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),

                Obx(() {
                  if (homeController.planname1.value == "basic") {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Image.asset(
                              IconPath.shield,
                              height: 36.67,
                              width: 30,
                            ),

                            SizedBox(height: 8),
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Name",
                                textAlign: TextAlign.center,
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF898989),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 44),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              IconPath.activeVs,
                              height: 28,
                              width: 44,
                            ),
                            SizedBox(height: 16),
                            Column(
                              children: [
                                Text(
                                  "Date",
                                  style: globalTextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                Text(
                                  "Time",
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
                        SizedBox(width: 44),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Image.asset(
                              IconPath.shield,
                              height: 36.67,
                              width: 30,
                            ),

                            SizedBox(height: 8),
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Name",
                                textAlign: TextAlign.center,
                                style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF898989),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox.shrink(),
                              gamesController.matches.isEmpty
                                  ? Image.asset(
                                    gamesController.iconPath1.value,
                                    height: 36.67,
                                    width: 30,
                                  )
                                  : Image.network(
                                    gamesController.matches.last.team1Logo,
                                    height: 36.67,
                                    width: 30,
                                  ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  gamesController.matches.isNotEmpty
                                      ? gamesController.matches.last.team1Name
                                      : "Name",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,

                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF898989),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(width: 44),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              IconPath.activeVs,
                              height: 28,
                              width: 44,
                            ),
                            SizedBox(height: 16),
                            Column(
                              children: [
                                Obx(() {
                                  return Text(
                                    gamesController.matches.isNotEmpty
                                        ? gamesController.matches.last.date
                                        : "Time",
                                    style: globalTextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }),
                                Obx(() {
                                  return Text(
                                    gamesController.matches.isNotEmpty
                                        ? gamesController.matches.last.time
                                        : "Time",
                                    style: globalTextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 44),
                        Obx(() {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox.shrink(),
                              gamesController.matches.isNotEmpty
                                  ? Image.network(
                                    gamesController.matches.isNotEmpty
                                        ? gamesController.matches.last.team2Logo
                                        : IconPath.shield,
                                    height: 36.67,
                                    width: 30,
                                  )
                                  : Image.asset(
                                    IconPath.activesheld,
                                    height: 36.67,
                                    width: 30,
                                  ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 90,
                                child: Text(
                                  gamesController.matches.isNotEmpty
                                      ? gamesController.matches.last.team2Name
                                      : "Name",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF898989),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  }
                }),
                SizedBox(height: 16),
                timecountdown(),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    height: 24,
                    width: 120,
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, // Change this to true
                          builder: (BuildContext context) {
                            return Dialog(
                              insetPadding: EdgeInsets.zero,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: SingleChildScrollView(
                                child: Container(
                                  height: 400,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  padding: EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Opponent Team',
                                        style: globalTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        controller: homeController.opponentTeam,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xff78828A),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF78828A),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                      // Text(
                                      //   'Home or Away',
                                      //   style: globalTextStyle(
                                      //     color: Color(0xFF333333),
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 10),
                                      // HomeORaWay(
                                      //   homeController: homeController,
                                      // ),
                                      // SizedBox(height: 16),
                                      Text(
                                        'Select Date',
                                        style: globalTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          border: Border.all(
                                            color: Color(0xFF78828A),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                selectDate(context);
                                              },
                                              child: Image.asset(
                                                IconPath.calendar,
                                                height: 24,
                                                width: 24,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Select a day',
                                                  style: globalTextStyle(
                                                    color: Color(0xFF565656),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Obx(() {
                                                  return Text(
                                                    homeController
                                                        .selectDate
                                                        .value,
                                                    style: globalTextStyle(
                                                      color: Color(0xFF00BA0B),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                      Text(
                                        'Select Time',
                                        style: globalTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Obx(
                                        () => TextFormField(
                                          readOnly: true,
                                          controller: TextEditingController(
                                            text:
                                                homeController
                                                    .selectedTime
                                                    .value,
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Select Time',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                color: Color(0xFF565656),
                                                width: 1,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                color: Color(0xFF565656),
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                color: Color(0xFF565656),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            TimeOfDay? selectedTime =
                                                await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );

                                            if (selectedTime != null) {
                                              homeController.updateSelectedTime(
                                                // ignore: use_build_context_synchronously
                                                selectedTime.format(context),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      SizedBox(
                                        width: double.infinity,
                                        child: GestureDetector(
                                          onTap: () {
                                            gamesController
                                                .onSaveChangesClicked();
                                            homeController.saveChanges();
                                            containerColor.value = Color(
                                              0xffE6F8E7,
                                            );
                                            focusedButtonIndex.value = 0;
                                            containerColor1.value = Color(
                                              0xff00BA0B,
                                            );
                                            showNoMatchData.value = false;
                                            Navigator.of(
                                              context,
                                            ).pop(); // Close the dialog after saving
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xff00BA0B),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Add Match',
                                                  style: globalTextStyle(
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
                              ),
                            );
                          },
                        );
                      },
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color:
                                  homeController.planname1.value == "basic"
                                      ? Color(0xFFBDBDBD)
                                      : Color(0xff0047AB),
                              size: 20,
                            ),
                            Text(
                              "Add Match",
                              style: globalTextStyle(
                                color:
                                    homeController.planname1.value == "basic"
                                        ? Color(0xFFBDBDBD)
                                        : Color(0xff0047AB),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ValueListenableBuilder<Color>(
            valueListenable: containerColor,
            builder: (context, color, child) {
              return Container(
                height: 49,
                width: 204,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          focusedButtonIndex.value = 0;
                          showNoMatchData.value = true;
                        },
                        child: ValueListenableBuilder<int>(
                          valueListenable: focusedButtonIndex,
                          builder: (context, value, child) {
                            return ValueListenableBuilder<Color>(
                              valueListenable: containerColor1,
                              builder: (context, color, child) {
                                return Container(
                                  height: 33,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    color:
                                        value == 0 ? color : Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Previous",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color:
                                            value == 0
                                                ? Colors.white
                                                : Color(0xff565656),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          focusedButtonIndex.value = 1;
                          showNoMatchData.value = false;
                        },
                        child: ValueListenableBuilder<int>(
                          valueListenable: focusedButtonIndex,
                          builder: (context, value, child) {
                            return ValueListenableBuilder(
                              valueListenable: containerColor1,
                              builder: (context, color, child) {
                                return Container(
                                  height: 33,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    color:
                                        value == 1 ? color : Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color:
                                            value == 1
                                                ? Colors.white
                                                : Color(0xff565656),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10),

          ValueListenableBuilder<bool>(
            valueListenable: showNoMatchData,
            builder: (context, showData, child) {
              return showData
                  ? Obx(() {
                    if (matchDataController.isLoading.value) {
                      return SizedBox.shrink();
                    } else {
                      // Sort the matchList by the match date in ascending order
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        matchDataController.matchList.sort((a, b) {
                          DateTime dateA = DateTime.parse(a.date.toString());
                          DateTime dateB = DateTime.parse(b.date.toString());
                          return dateB.compareTo(dateA);
                        });
                      });
                      return Expanded(
                        child:
                            matchDataController.matchList.isEmpty
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 196,
                                      width: 321.41,
                                      child: Image.asset(ImagePath.chackImage),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "No Match Data Yet",
                                      style: globalTextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff565656),
                                      ),
                                    ),
                                    SizedBox(height: 74),
                                  ],
                                )
                                : ListView.builder(
                                  itemCount:
                                      matchDataController.matchList.length,
                                  itemBuilder: (context, index) {
                                    final matchData =
                                        matchDataController.matchList[index];

                                    DateTime matchDate = DateTime.parse(
                                      matchData.date.toString(),
                                    );

                                    DateTime currentDate = DateTime.now();

                                    String formattedMatchDate = DateFormat(
                                      'yyyy-MM-dd – HH:mm',
                                    ).format(matchDate);
                                    String formattedCurrentDate = DateFormat(
                                      'yyyy-MM-dd – HH:mm',
                                    ).format(currentDate);

                                    String dateAndTime = DateFormat(
                                      'd MMM h:mm a',
                                    ).format(matchDate);
                                    Duration difference = matchDate.difference(
                                      currentDate,
                                    );
                                    int differenceInDays = difference.inDays;

                                    if (differenceInDays <= 0) {
                                      return GestureDetector(
                                        onTap: () {
                                          _showMatchDialog(context, matchData);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 353,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xffE6EDF7),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 115,
                                                    height: 32.26,
                                                    child: Row(
                                                      children: [
                                                        matchData.logoUrl ==
                                                                null
                                                            ? Image.asset(
                                                              IconPath.cbflogo,
                                                              width: 24,
                                                              height: 32.26,
                                                            )
                                                            : Image.network(
                                                              matchData
                                                                      .logoUrl ??
                                                                  "",
                                                              width: 24,
                                                              height: 32.26,
                                                            ),
                                                        SizedBox(width: 4.0),
                                                        Expanded(
                                                          child: Text(
                                                            matchData.clubName,
                                                            style:
                                                                globalTextStyle(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Align(
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 90,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${matchData.totalGoals.toString()} - ${matchData.opponentGoals.toString()}", // Use dynamic data
                                                            style:
                                                                globalTextStyle(
                                                                  color: Color(
                                                                    0xff0047AB,
                                                                  ),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Text(
                                                            dateAndTime,
                                                            style:
                                                                globalTextStyle(
                                                                  color: Color(
                                                                    0xff565656,
                                                                  ),
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 24,
                                                    width: 76,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            matchData
                                                                .opponentTeam,
                                                            style:
                                                                globalTextStyle(
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 4.0),
                                                        matchData.logoUrl ==
                                                                null
                                                            ? Image.asset(
                                                              IconPath.cbflogo,
                                                              width: 24,
                                                              height: 32.26,
                                                            )
                                                            : Image.network(
                                                              matchData
                                                                      .logoUrl ??
                                                                  "",
                                                              width: 24,
                                                              height: 32.26,
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                      );
                    }
                  })
                  : Obx(() {
                    if (matchDataController.isLoading.value) {
                      // EasyLoading.show(status: "loading...");

                      return SizedBox.shrink();
                    } else {
                      // EasyLoading.dismiss();
                      // Sort the matchList by the match date in ascending order
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        matchDataController.matchList.sort((a, b) {
                          DateTime dateA = DateTime.parse(a.date.toString());
                          DateTime dateB = DateTime.parse(b.date.toString());
                          return dateB.compareTo(dateA);
                        });
                      });

                      return Expanded(
                        child:
                            matchDataController.matchList.isEmpty
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 196,
                                      width: 321.41,
                                      child: Image.asset(ImagePath.chackImage),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "No Match Data Yet",
                                      style: globalTextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff565656),
                                      ),
                                    ),
                                    SizedBox(height: 74),
                                  ],
                                )
                                : ListView.builder(
                                  itemCount:
                                      matchDataController.matchList.length,
                                  itemBuilder: (context, index) {
                                    final matchData =
                                        matchDataController.matchList[index];

                                    DateTime matchDate = DateTime.parse(
                                      matchData.date.toString(),
                                    );

                                    DateTime currentDate = DateTime.now();

                                    String formattedMatchDate = DateFormat(
                                      'yyyy-MM-dd – HH:mm',
                                    ).format(matchDate);
                                    String formattedCurrentDate = DateFormat(
                                      'yyyy-MM-dd – HH:mm',
                                    ).format(currentDate);

                                    String dateAndTime = DateFormat(
                                      'd MMM h:mm a',
                                    ).format(matchDate);

                                    Duration difference = matchDate.difference(
                                      currentDate,
                                    );
                                    int differenceInDays = difference.inDays;

                                    if (differenceInDays > 0) {
                                      return NextDifferenceInDaysList(
                                        matchData: matchData,
                                        differenceInDays: differenceInDays,
                                        dateAndTime: dateAndTime,
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                      );
                    }
                  });
            },
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> addmatch_showdialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Opponent Team',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  OpponentTeamSelected(homeController: homeController),
                  SizedBox(height: 16),
                  Text(
                    'Home or Away',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  HomeORaWay(homeController: homeController),
                  SizedBox(height: 16),
                  Text(
                    'Select Date',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xFF78828A)),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectDate(context);
                          },
                          child: Image.asset(
                            IconPath.calendar,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select a day',
                              style: globalTextStyle(
                                color: Color(0xFF565656),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                homeController.selectDate.value,
                                style: globalTextStyle(
                                  color: Color(0xFF00BA0B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Time',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  AuthCustomTextField(
                    controller: homeController.timeController,
                    text: '3:00 PM',
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        gamesController.onSaveChangesClicked();
                        homeController.saveChanges();
                        containerColor.value = Color(0xffE6F8E7);
                        focusedButtonIndex.value = 0;
                        containerColor1.value = Color(0xff00BA0B);
                        showNoMatchData.value = false;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff00BA0B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Add Match',
                              style: globalTextStyle(
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
          ),
        );
      },
    );
  }

  void _showMatchDialog(BuildContext context, MatchNewModel matchData) {
    // Assuming matchData.date is a string, parse it into DateTime.
    DateTime matchDate = DateTime.parse(matchData.date.toString());
    // Format the matchDate using '14 Feb 3:00 PM' or 'AM' format
    String dateAndTime = DateFormat('d MMM h:mm a').format(matchDate);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
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

                          // color: Color(0xffE6F8E7),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(GamesEditScreen(matchData: matchData));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            matchData.logoUrl == null
                                ? Image.asset(
                                  IconPath.cbflogo,
                                  height: 42,
                                  width: 40,
                                )
                                : Image.network(
                                  matchData.logoUrl!,
                                  height: 42,
                                  width: 40,
                                ),
                            Text(
                              matchData.clubName,
                              style: globalTextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              "${matchData.totalGoals.toString()}-${matchData.opponentGoals.toString()}",
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
                                  "${matchData.duration.toString()} Min",
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
                              matchData.logoUrl == null
                                  ? Image.asset(
                                    IconPath.cbflogo,
                                    height: 42,
                                    width: 40,
                                  )
                                  : Image.network(
                                    matchData.logoUrl!,
                                    height: 42,
                                    width: 40,
                                  ),
                              Text(
                                matchData.opponentTeam,
                                overflow:
                                    TextOverflow
                                        .ellipsis, // This adds the ellipsis
                                maxLines: 1,
                                style: globalTextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0.5, indent: 15, endIndent: 15),
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
                            Text("Vini Jr 8',65'"),
                            Text("Mbappe 45'"),
                            Text("Belingham 78'"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Y.Asprilla 34'"),
                            Text("A. Ruiz 83'"),
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
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF00BA0B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
      homeController.updateDat(formattedDate);
    }
  }
}

class NextDifferenceInDaysList extends StatelessWidget {
  const NextDifferenceInDaysList({
    super.key,
    required this.matchData,
    required this.differenceInDays,
    required this.dateAndTime,
  });

  final MatchNewModel matchData;
  final int differenceInDays;
  final String dateAndTime;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // You can use conditions based on screen width or height to adjust layout
    bool isSmallScreen =
        screenWidth < 360; // Example: if screen is smaller than 360px

    return Column(
      children: [
        Container(
          height: 70, // Adjust height for small screens
          width: 353, // Adjust width based on screen size
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE6EDF7)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                height: 32.26,
                child: Row(
                  children: [
                    matchData.logoUrl == null
                        ? Image.asset(IconPath.cbflogo, width: 24, height: 24)
                        : Image.network(
                          matchData.logoUrl ?? "",
                          width: 24,
                          height: 24,
                        ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        matchData.clubName,
                        style: globalTextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 90,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffE6EDF7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "In $differenceInDays day",
                        style: globalTextStyle(
                          color: Color(0xff0047AB),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      dateAndTime,
                      style: globalTextStyle(
                        color: Color(0xff565656),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
                width: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        matchData.opponentTeam,
                        style: globalTextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    matchData.logoUrl == null
                        ? Image.asset(IconPath.clublogo, height: 24, width: 24)
                        : Image.network(
                          matchData.logoUrl ?? "",
                          width: 24,
                          height: 24,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
