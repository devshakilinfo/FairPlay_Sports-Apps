import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';
import 'package:sports_apps/features/home/screen/live_match.dart';
import 'package:sports_apps/routes/app_routes.dart';

import '../../../core/custom_widget/upgreade_pro_container.dart'
    show UpgradeProContainer;
import '../../user_profile/controller/user_profile_controller.dart'
    show UserProfileController;
import '../widget/managelineup_and_gamesetup.dart' show ManageLineup_GameSetup;
import '../widget/player_time_calculator.dart' show PlayerTimeCalculator;

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());
  final userProfileController = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    // userProfileController.fetchprofile();
    // debugPrint("userProfileController.planNmae.value${userProfileController.planNmae.trim()}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => LiveMatch()),
        //       );
        //     },
        //     child: Image.asset(IconPath.realmadrid, height: 44, width: 44),
        //   ),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (userProfileController.clubName.value.isEmpty) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    userProfileController.clubName.value,
                    style: globalTextStyle(
                      color: Color(0xFF082B09),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
            }),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiveMatch()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Your Team",
                  style: globalTextStyle(
                    color: Color(0xFF898989),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.subscriptionPlanScreen);
                  },
                  child: Container(
                    width: 67,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF00BA0B)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Center(
                        child: Text(
                          'Go Pro',
                          style: globalTextStyle(
                            color: Color(0xFF00BA0B),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.userProfileScreen);
                  },
                  child: Obx(() {
                    if (userProfileController.logoUrl.value.isEmpty) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          userProfileController.logoUrl.value,
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Color(0xFFE6EDF7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(),
                          Text(
                            'Next Match Preparation',
                            style: globalTextStyle(
                              color:
                                  homeController.planname1.value == "basic"
                                      ? Color(0xFFABABAB)
                                      : Color(0xFF565656),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          homeController.planname1.value == "basic"
                              ? Image.asset(
                                IconPath.lock1,
                                height: 20,
                                width: 20,
                              )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Obx(() {
                              return SizedBox(
                                child:
                                    homeController.matchedetails.isNotEmpty
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          child: Image.network(
                                            homeController
                                                .matchedetails
                                                .last
                                                .logoUrl!,
                                            height: 40,
                                            width: 40,
                                          ),
                                        )
                                        : Image.asset(
                                          homeController.planname1.value ==
                                                  "basic"
                                              ? IconPath.shield
                                              : IconPath.activesheld,
                                          height: 40,
                                          width: 40,
                                        ),
                              );
                            }),
                            SizedBox(height: 8),
                            Obx(
                              () => SizedBox(
                                width: 80,
                                child: Text(
                                  homeController.matchedetails.isNotEmpty
                                      ? homeController
                                          .matchedetails
                                          .last
                                          .clubName
                                      : "Name",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        homeController.planname1.value ==
                                                "basic"
                                            ? Color(0xFF898989)
                                            : Color(0xFF565656),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 44),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeController.planname1.value == "basic"
                                ? Image.asset(
                                  IconPath.vs,
                                  height: 38,
                                  width: 74,
                                )
                                : Image.asset(
                                  IconPath.activeVs,
                                  height: 38,
                                  width: 74,
                                ),
                            SizedBox(height: 16),
                            Column(
                              children: [
                                Obx(
                                  () => Text(
                                    homeController.matchedetails.isNotEmpty
                                        ? homeController.matchedetails.last.date
                                        : "Date",
                                    style: globalTextStyle(
                                      color:
                                          homeController.planname1.value ==
                                                  "basic"
                                              ? Color(0xFF898989)
                                              : Color(0xFF565656),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    homeController.matchedetails.isNotEmpty
                                        ? homeController.matchedetails.last.time
                                        : "Time",
                                    style: globalTextStyle(
                                      color:
                                          homeController.planname1.value ==
                                                  "basic"
                                              ? Color(0xFF898989)
                                              : Color(0xFF565656),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 44),
                        Column(
                          children: [
                            Obx(() {
                              return homeController.matchedetails.isNotEmpty
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      homeController
                                          .matchedetails
                                          .last
                                          .logoUrl!,
                                      height: 40,
                                      width: 40,
                                    ),
                                  )
                                  : Image.asset(
                                    homeController.planname1.value == "basic"
                                        ? IconPath.shield
                                        : IconPath.activesheld,
                                    height: 40,
                                    width: 40,
                                  );
                            }),

                            SizedBox(height: 8),
                            Obx(
                              () => SizedBox(
                                width: 80,
                                child: Text(
                                  homeController.matchedetails.isNotEmpty
                                      ? homeController
                                          .matchedetails
                                          .last
                                          .opponentTeam
                                      : "Name",
                                  textAlign: TextAlign.center,
                                  style: globalTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        homeController.planname1.value ==
                                                "basic"
                                            ? Color(0xFF898989)
                                            : Color(0xFF565656),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimeBox(
                            homeController.days.value.toString().padLeft(
                              2,
                              '0',
                            ),
                            'Days',
                          ),
                          SizedBox(width: 8),
                          _buildTimeBox(
                            homeController.hours.value.toString().padLeft(
                              2,
                              '0',
                            ),
                            'Hours',
                          ),
                          SizedBox(width: 8),
                          _buildTimeBox(
                            homeController.minutes.value.toString().padLeft(
                              2,
                              '0',
                            ),
                            'Min',
                          ),
                          SizedBox(width: 8),
                          _buildTimeBox(
                            homeController.seconds.value.toString().padLeft(
                              2,
                              '0',
                            ),
                            'Sec',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    GetX<HomeController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.isButtonVisible.value,
                          child: GestureDetector(
                            onTap: () {
                              if (homeController.planname1.value != "basic") {
                                controller.isButtonVisible.value = false;
                                controller.isOpponentTeamVisible.value = true;
                              } else {
                                debugPrint(
                                  "You cannot add a match with the basic plan",
                                );
                              }
                            },
                            child: Obx(
                              () => Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      homeController.planname1.value == "basic"
                                          ? Color(0xFF898989)
                                          : Color(0xFF00BA0B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.isButtonVisible.value
                                        ? 'Add Match'
                                        : 'Edit',
                                    style: globalTextStyle(
                                      color:
                                          homeController.planname1.value ==
                                                  "basic"
                                              ? Color(0xFFBDBDBD)
                                              : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GetX<HomeController>(
                      builder: (controller) {
                        return AnimatedOpacity(
                          opacity:
                              controller.isOpponentTeamVisible.value
                                  ? 1.0
                                  : 0.0,
                          duration: Duration(milliseconds: 300),
                          child:
                              controller.isOpponentTeamVisible.value
                                  ? Column(
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

                                      // OpponentTeamSelected(
                                      //   homeController: homeController,
                                      // ),
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

                                      SizedBox(height: 16),
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
                                                Text(
                                                  homeController
                                                      .selectDate
                                                      .value, // Display the full date string
                                                  style: globalTextStyle(
                                                    color: Color(0xFF00BA0B),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Enter Time',
                                        style: globalTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        readOnly: true,
                                        controller: TextEditingController(
                                          text:
                                              homeController.selectedTime.value,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Select Time',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF565656),
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF565656),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
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
                                            // Update selected time in the controller
                                            homeController.updateSelectedTime(
                                              // ignore: use_build_context_synchronously
                                              selectedTime.format(context),
                                            );
                                          }
                                        },
                                      ),

                                      SizedBox(height: 32),
                                      CustomButton(
                                        title: 'Manage Squad',
                                        onPress: () {
                                          Get.toNamed(AppRoute.gamesLineup);
                                        },
                                        backgroundColor: Colors.white,
                                        textcolor: Color(0xFF00BA0B),
                                      ),
                                      SizedBox(height: 12),
                                      CustomButton(
                                        title: 'Save Changes',
                                        onPress: () {
                                          homeController.saveChanges();
                                        },
                                      ),
                                      SizedBox(height: 28),
                                    ],
                                  )
                                  : SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 29),
              PlayerTimeCalculator(), // =====================================================================================
              SizedBox(height: 50),
              Obx(
                () => ManageLineup_GameSetup(
                  planName: homeController.planname1.value,
                ),
              ), // ======================= manage lineup and game setup widget
              SizedBox(height: 40),
              UpgradeProContainer(
                onTap: () {
                  Get.toNamed(AppRoute.subscriptionPlanScreen);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.127),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBox(String time, String label) {
    return Container(
      height: 60,
      width: 55,
      decoration: BoxDecoration(
        color: Color(0xFFE6EDF7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Text(
              time,
              key: ValueKey<String>(time), // Unique key to trigger animation
              style: TextStyle(
                color: Color(0xFF565656),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF565656),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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
