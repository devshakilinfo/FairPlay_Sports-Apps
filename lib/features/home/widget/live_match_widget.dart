import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/progress_controller.dart';

import '../../user_profile/controller/live_match_controller.dart';

final ProgressController controller = Get.put(ProgressController());

Container livematch(
  double textFontSize, {
  required LiveMatchController liveMtachController,
}) {
  return Container(
    height: 377,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(width: 1, color: Color(0xffE6EDF7)),
    ),
    child: Obx(() {
      // Check if the data is loading or if there is an error
      if (liveMtachController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (liveMtachController.liveMatches.isEmpty) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.shrink(),
                      Image.asset(IconPath.clublogo, height: 45, width: 40),
                      SizedBox(height: 8),
                      Text(
                        'RM',
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 44),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "0-0",
                        style: globalTextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff565656),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        height: 25,
                        width: 46,
                        decoration: BoxDecoration(
                          color: Color(0xffE6EDF7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "00:00",
                            style: globalTextStyle(
                              color: Color(0xff0047AB),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 44),
                  Column(
                    children: [
                      Image.asset(IconPath.cbflogo, height: 40.56, width: 40),
                      SizedBox(height: 8),
                      Text(
                        'FCB',
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 33,
                  width: 74,
                  decoration: BoxDecoration(
                    color: Color(0xffEA2525),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Live",
                      style: globalTextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 34),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    "Your Progress",
                    style: globalTextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff8D8D8D),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${(controller.progress.value * 100).toStringAsFixed(0)}% completed",
                            style: globalTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff00BA0B),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Image.asset(IconPath.clock, height: 16, width: 16),
                            SizedBox(width: 5),
                            Text(
                              "60 min",
                              style: globalTextStyle(
                                fontSize: 12,
                                color: Color(0xff565656),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Linear Progress Bar
                  Obx(() {
                    double progressValue = controller.progress.value;
                    int totalSteps =
                        60; // Number of steps (for example, 60 minutes)

                    return Stack(
                      children: [
                        // Linear Progress Bar
                        LinearPercentIndicator(
                          lineHeight: 14.0,
                          percent: progressValue,
                          progressColor: Color(0xff0047AB),
                          backgroundColor: Color(0xffE6F8E7),
                          barRadius: Radius.circular(10),
                        ),
                        // Circular markers (placed every 10%)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(totalSteps ~/ 15, (
                                index,
                              ) {
                                double stepPercent = (index + 1) * 1 / 100;
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AnimatedOpacity(
                                      opacity:
                                          progressValue >= stepPercent
                                              ? 1.0
                                              : 0.3,
                                      duration: Duration(milliseconds: 300),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            progressValue >= stepPercent
                                                ? Color(0xff0047AB)
                                                : Colors.white,
                                        radius: 8,
                                        child:
                                            progressValue >= stepPercent
                                                ? Icon(
                                                  Icons.circle,
                                                  size: 4,
                                                  color: Colors.white,
                                                )
                                                : null,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Duration',
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
                                    controller.selectedDuration.value,
                                    style: globalTextStyle(
                                      color: Color(0xff333333),
                                      fontSize: textFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  color: Colors.white,
                                  icon: Image.asset(
                                    IconPath.dropdown,
                                    height: 32,
                                    width: 32,
                                  ),
                                  onSelected: (String value) {
                                    controller.setDuration(value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: '30 Min',
                                        child: Text('30 Min'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: '60 Min',
                                        child: Text('60 Min'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: '90 Min',
                                        child: Text('90 Min'),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rotation',
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
                                    controller.selectedRotation.value,
                                    style: globalTextStyle(
                                      color: Color(0xff333333),
                                      fontSize: textFontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  color: Colors.white,
                                  icon: Image.asset(
                                    IconPath.dropdown,
                                    height: 32,
                                    width: 32,
                                  ),
                                  onSelected: (String value) {
                                    controller.setRotation(value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: '4',
                                        child: Text('4'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: '8',
                                        child: Text('8'),
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
            ),
          ],
        );
      }
      return ListView.builder(
        itemCount: liveMtachController.liveMatches.length,
        itemBuilder: (context, index) {
          var match = liveMtachController.liveMatches[index];
          liveMtachController.setPlayerId(match.id);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        match.logoUrl == null
                            ? Image.asset(
                              IconPath.clublogo,
                              height: 45,
                              width: 40,
                            )
                            : Image.network(
                              match.logoUrl ?? "",
                              height: 45,
                              width: 40,
                            ),
                        SizedBox(height: 8),
                        Text(
                          '${match.clubName?.substring(0, 8)}',
                          style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 44),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${match.totalGoals}-${match.opponentGoals}",
                          style: globalTextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff565656),
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          height: 25,
                          width: 46,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xffE6EDF7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${match.time}",
                            style: globalTextStyle(
                              color: Color(0xff0047AB),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 44),
                    Column(
                      children: [
                        match.logoUrl == null
                            ? Image.asset(
                              IconPath.clublogo,
                              height: 45,
                              width: 40,
                            )
                            : Image.network(
                              match.logoUrl ?? "",
                              height: 45,
                              width: 40,
                            ),
                        SizedBox(height: 8),
                        Text(
                          '${match.opponentTeam?.substring(0, 6)}',
                          style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 33,
                    width: 74,
                    decoration: BoxDecoration(
                      color: Color(0xffEA2525),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Live",
                        style: globalTextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    child: Text(
                      "Your Progress",
                      style: globalTextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff8D8D8D),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "${(controller.progress.value * 100).toStringAsFixed(0)}% completed",
                              style: globalTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff00BA0B),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                IconPath.clock,
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${match.duration} min",
                                style: globalTextStyle(
                                  fontSize: 12,
                                  color: Color(0xff565656),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Linear Progress Bar
                    Obx(() {
                      double progressValue = controller.progress.value;
                      int totalSteps =
                          60; // Number of steps (for example, 60 minutes)

                      return Stack(
                        children: [
                          // Linear Progress Bar
                          LinearPercentIndicator(
                            lineHeight: 14.0,
                            percent: (match.duration ?? 0).toDouble() / 100.0,
                            progressColor: Color(0xff0047AB),
                            backgroundColor: Color(0xffE6F8E7),
                            barRadius: Radius.circular(10),
                          ),

                          // Circular markers (placed every 10%)
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(totalSteps ~/ 15, (
                                  index,
                                ) {
                                  double stepPercent = (index + 1) * 1 / 100;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: AnimatedOpacity(
                                        opacity:
                                            progressValue >= stepPercent
                                                ? 1.0
                                                : 0.3,
                                        duration: Duration(milliseconds: 300),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              progressValue >= stepPercent
                                                  ? Color(0xff0047AB)
                                                  : Colors.white,
                                          radius: 8,
                                          child:
                                              progressValue >= stepPercent
                                                  ? Icon(
                                                    Icons.circle,
                                                    size: 4,
                                                    color: Colors.white,
                                                  )
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration',
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
                                      controller.selectedDuration.value,
                                      style: globalTextStyle(
                                        color: Color(0xff333333),
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: 32,
                                      width: 32,
                                    ),
                                    onSelected: (String value) {
                                      controller.setDuration(value);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: '30 Min',
                                          child: Text('30 Min'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: '60 Min',
                                          child: Text('60 Min'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: '90 Min',
                                          child: Text('90 Min'),
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
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rotation',
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
                                      controller.selectedRotation.value,
                                      style: globalTextStyle(
                                        color: Color(0xff333333),
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: 32,
                                      width: 32,
                                    ),
                                    onSelected: (String value) {
                                      controller.setRotation(value);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: '4',
                                          child: Text('4'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: '8',
                                          child: Text('8'),
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
              ),
            ],
          );
        },
      );
    }),
  );
}
