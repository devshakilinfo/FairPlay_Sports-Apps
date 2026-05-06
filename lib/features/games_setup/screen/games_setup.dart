
import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/home/controller/Home_controller.dart';
import 'package:sports_apps/routes/app_routes.dart';
import '../controller/games_setup_controller.dart' show GamesSetupController;

// ignore: must_be_immutable
class GamesSetup extends StatelessWidget {
  GamesSetup({super.key});
  final GamesSetupController gamesSetupController = Get.put(
    GamesSetupController(),
  );
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Game Setup',
          style: globalTextStyle(
            color: const Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body:
          homeController.planname1.value == 'basic'
              ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Game Duration',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CarouselSlider(
                        items:
                            gamesSetupController.times.map((time) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Obx(() {
                                    final int index = gamesSetupController.times
                                        .indexOf(time);
                                    final bool isSelected =
                                        index ==
                                        gamesSetupController
                                            .selectedIndex
                                            .value;
                                    final double scale = isSelected ? 1 : 1;
                                    return Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        width: 53,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? const Color(0xFFE6F8E7)
                                                  : const Color(0xFFE6F8E7),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? const Color(0xFF00BA0B)
                                                    : const Color(0xFFE6F8E7),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              time,
                                              style: globalTextStyle(
                                                fontSize: isSelected ? 16 : 10,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                          0xFF00BA0B,
                                                        )
                                                        : const Color(
                                                          0xFF565656,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'min',
                                              style: globalTextStyle(
                                                fontSize: isSelected ? 16 : 10,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                          0xFF00BA0B,
                                                        )
                                                        : const Color(
                                                          0xFF565656,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            }).toList(),
                        options: CarouselOptions(
                          height: 82,
                          viewportFraction: 0.26,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            gamesSetupController.updateIndex(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Game Setup (in minutes)',
                            style: globalTextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconPath.edit,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  'Custom',
                                  style: globalTextStyle(
                                    color: const Color(0xFF0047AB),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Obx(() {
                        return Slider(
                          value:
                              gamesSetupController.currentTime.value.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label:
                              '${gamesSetupController.currentTime.value} minutes',
                          onChanged: (value) {
                            gamesSetupController.currentTime.value =
                                value.toInt();
                          },
                          activeColor: const Color(0xFF165C16),
                          // ignore: deprecated_member_use
                          inactiveColor: const Color(
                            0xFF165C16,
                          ).withValues(alpha:  0.3),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(IconPath.zero, height: 30, width: 40),
                          Image.asset(IconPath.one, height: 30, width: 40),
                          Image.asset(IconPath.two, height: 30, width: 40),
                          Image.asset(IconPath.three, height: 30, width: 40),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Game format(Number of Players)',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController.selectedFormation.value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController.updateFormation(
                                  value,
                                ); // Update formation and players
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(
                                    value: '7 v 7',
                                    child: Text('7 v 7'),
                                  ),
                                  PopupMenuItem(
                                    value: '8 v 8',
                                    child: Text('8 v 8'),
                                  ),
                                  PopupMenuItem(
                                    value: '9 v 9',
                                    child: Text('9 v 9'),
                                  ),
                                  PopupMenuItem(
                                    value: '10 v 10',
                                    child: Text('10 v 10'),
                                  ),
                                  PopupMenuItem(
                                    value: '11 v 11',
                                    child: Text('11 v 11'),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Number of Rotations',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController.selectedRotaion.value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController.selectedRotaion.value =
                                    value;
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(value: '7', child: Text('7')),
                                  PopupMenuItem(value: '8', child: Text('8')),
                                  PopupMenuItem(value: '9', child: Text('9')),
                                  PopupMenuItem(value: '10', child: Text('10')),
                                  PopupMenuItem(value: '11', child: Text('11')),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                      Text(
                        'Goalkeeper Rotation',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController
                                    .selectedGoalKeeperRotaion
                                    .value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController
                                    .selectedGoalKeeperRotaion
                                    .value = value;
                                gamesSetupController.updateGoalKeeperRotation(
                                  value,
                                );
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(
                                    value: 'Yes',
                                    child: Text('Yes'),
                                  ),
                                  PopupMenuItem(value: 'No', child: Text('No')),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Player Names',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          children: [
                            Obx(() {
                              return SingleChildScrollView(
                                // Allow scroll if content overflows
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1.8,
                                      ),
                                  itemCount:
                                      gamesSetupController.controllers.length,
                                  itemBuilder: (context, index) {
                                    // Safety check
                                    if (index >=
                                        gamesSetupController
                                            .isGoalkeeperList
                                            .length) {
                                      return const SizedBox(); // Return empty widget if index is out of bounds
                                    }

                                    return Column(
                                      children: [
                                        AuthCustomTextField(
                                          controller:
                                              gamesSetupController
                                                  .controllers[index],
                                          text: 'Player ${index + 1} Name',
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Obx(() {
                                              return Checkbox(
                                                value:
                                                    gamesSetupController
                                                        .isGoalkeeperList[index],
                                                onChanged: (bool? value) {
                                                  if (value != null) {
                                                    gamesSetupController
                                                            .isGoalkeeperList[index] =
                                                        value;
                                                    gamesSetupController
                                                        .updateGoalKeepers();
                                                  }
                                                },
                                              );
                                            }),

                                            const Text(
                                              'Goalkeeper',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }),

                            // CustomButton(
                            //   title: "Add Players",
                            //   onPress: () {
                            //     gamesSetupController.addPlayers();
                            //   },
                            // ),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Zone Rotation',
                      //           style: globalTextStyle(
                      //             color: const Color(0xFFABABAB),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         const SizedBox(width: 5),
                      //         Image.asset(
                      //           IconPath.lock,
                      //           height: 12,
                      //           width: 12,
                      //           color: const Color(0xFFABABAB),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Position Rotation',
                      //           style: globalTextStyle(
                      //             color: const Color(0xFFABABAB),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         const SizedBox(width: 5),
                      //         Image.asset(
                      //           IconPath.lock,
                      //           height: 12,
                      //           width: 12,
                      //           color: const Color(0xFFABABAB),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 12),
                      // RadioButton(gamesSetupController: gamesSetupController),
                      SizedBox(height: 40),
                      CustomButton(
                        title: 'Calculate Fair Play Time',
                        onPress: () async {
                          await gamesSetupController.gamesetup();
                          Get.toNamed(AppRoute.calculateTime);
                        },
                      ),
                      SizedBox(height: 33),

                      //comment for premium
                      //===============================================================================

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Formation',
                      //       style: globalTextStyle(
                      //         color: Color(0xFFABABAB),
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     SizedBox(width: 5),
                      //     Image.asset(IconPath.lock1, height: 20, width: 20),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // FormationButtonRow2(), // ======================================= formation button row
                      // SizedBox(height: 20),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Image.asset(ImagePath.football, fit: BoxFit.cover),
                      //     // Player 1
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.055,
                      //     ),
                      //     // Player 2
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'RWF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.105,
                      //       right: MediaQuery.of(context).size.height * 0.04,
                      //     ),
                      //     // Player 3
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'LWF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.105,
                      //       left: MediaQuery.of(context).size.height * 0.04,
                      //     ),
                      //     // Player 4
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'AM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.210,
                      //     ),
                      //     // Player 5
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.310,
                      //       left: MediaQuery.of(context).size.height * 0.07,
                      //     ),
                      //     // Player 6
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.310,
                      //       right: MediaQuery.of(context).size.height * 0.08,
                      //     ),
                      //     // Player 7
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'RB',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.190,
                      //       right: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //     // Player 8
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'LB',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.190,
                      //       left: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //     // Player 9
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.160,
                      //       left: MediaQuery.of(context).size.height * 0.12,
                      //     ),
                      //     // Player 10
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.160,
                      //       right: MediaQuery.of(context).size.height * 0.12,
                      //     ),
                      //     // Player 11
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'GK',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.028,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Text(
                      //   'Player Rotation',
                      //   style: globalTextStyle(
                      //     color: Color(0xFFABABAB),
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //     border: Border.all(color: Color(0xFFE6EDF7)),
                      //   ),
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.only(bottom: 4),
                      //         child: PlayerRotationRow(
                      //           gamesSetupController: gamesSetupController,
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: 40),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: CustomButton(
                      //         title: 'Reset',
                      //         onPress: () {
                      //           //
                      //         },
                      //         backgroundColor: Colors.white,
                      //         textcolor: Color(0xFF00BA0B),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: CustomButton(
                      //         title: 'Save Changes',
                      //         onPress: () {
                      //           //
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      //=====================================================================================
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Game Duration',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CarouselSlider(
                        items:
                            gamesSetupController.times.map((time) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Obx(() {
                                    final int index = gamesSetupController.times
                                        .indexOf(time);
                                    final bool isSelected =
                                        index ==
                                        gamesSetupController
                                            .selectedIndex
                                            .value;
                                    final double scale = isSelected ? 1 : 1;
                                    return Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        width: 53,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? const Color(0xFFE6F8E7)
                                                  : const Color(0xFFE6F8E7),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? const Color(0xFF00BA0B)
                                                    : const Color(0xFFE6F8E7),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              time,
                                              style: globalTextStyle(
                                                fontSize: isSelected ? 16 : 10,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                          0xFF00BA0B,
                                                        )
                                                        : const Color(
                                                          0xFF565656,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'min',
                                              style: globalTextStyle(
                                                fontSize: isSelected ? 16 : 10,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                          0xFF00BA0B,
                                                        )
                                                        : const Color(
                                                          0xFF565656,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            }).toList(),
                        options: CarouselOptions(
                          height: 82,
                          viewportFraction: 0.26,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            gamesSetupController.updateIndex(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Game Setup (in minutes)',
                            style: globalTextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconPath.edit,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  'Custom',
                                  style: globalTextStyle(
                                    color: const Color(0xFF0047AB),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Obx(() {
                        return Slider(
                          value:
                              gamesSetupController.currentTime.value.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label:
                              '${gamesSetupController.currentTime.value} minutes',
                          onChanged: (value) {
                            gamesSetupController.currentTime.value =
                                value.toInt();
                          },
                          activeColor: const Color(0xFF165C16),
                          // ignore: deprecated_member_use
                          inactiveColor: const Color(
                            0xFF165C16,
                          ).withValues(alpha:  0.3),
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(IconPath.zero, height: 30, width: 40),
                          Image.asset(IconPath.one, height: 30, width: 40),
                          Image.asset(IconPath.two, height: 30, width: 40),
                          Image.asset(IconPath.three, height: 30, width: 40),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Game format(Number of Players)',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController.selectedFormation.value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController.updateFormation(
                                  value,
                                ); // Update formation and players
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(
                                    value: '7 v 7',
                                    child: Text('7 v 7'),
                                  ),
                                  PopupMenuItem(
                                    value: '8 v 8',
                                    child: Text('8 v 8'),
                                  ),
                                  PopupMenuItem(
                                    value: '9 v 9',
                                    child: Text('9 v 9'),
                                  ),
                                  PopupMenuItem(
                                    value: '10 v 10',
                                    child: Text('10 v 10'),
                                  ),
                                  PopupMenuItem(
                                    value: '11 v 11',
                                    child: Text('11 v 11'),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Number of Rotations',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController.selectedRotaion.value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController.selectedRotaion.value =
                                    value;
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(value: '7', child: Text('7')),
                                  PopupMenuItem(value: '8', child: Text('8')),
                                  PopupMenuItem(value: '9', child: Text('9')),
                                  PopupMenuItem(value: '10', child: Text('10')),
                                  PopupMenuItem(value: '11', child: Text('11')),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                      Text(
                        'Goalkeeper Rotation',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF78828A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                gamesSetupController
                                    .selectedGoalKeeperRotaion
                                    .value,
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Image.asset(
                                IconPath.dropdown,
                                height: 20,
                                width: 20,
                              ),
                              onSelected: (String value) {
                                gamesSetupController
                                    .selectedGoalKeeperRotaion
                                    .value = value;
                                gamesSetupController.updateGoalKeeperRotation(
                                  value,
                                );
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem(
                                    value: 'Yes',
                                    child: Text('Yes'),
                                  ),
                                  PopupMenuItem(value: 'No', child: Text('No')),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Player Names',
                        style: globalTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Column(
                          children: [
                            Obx(() {
                              return SingleChildScrollView(
                                // Allow scroll if content overflows
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1.8,
                                      ),
                                  itemCount:
                                      gamesSetupController.controllers.length,
                                  itemBuilder: (context, index) {

                                    String some = '';
                                  


                                    try {
                                      if(homeController.allpalyers[index].player == null) {
                                      some = 'No player';

                                    } else if(homeController.allpalyers[index].player != null) {
                                      some = homeController.allpalyers[index].player!.name.toString();
                                    }
                                    } catch (e) {
                                      some = 'No Player';
                                    }

                                 
                                     
                                
                      
                                  
                                    if (index >=
                                        gamesSetupController
                                            .isGoalkeeperList
                                            .length) {
                                      return const SizedBox(); // Return empty widget if index is out of bounds
                                    }

                                    return Column(
                                      children: [
                                        AuthCustomTextField(
                                          controller:gamesSetupController.controllers[index],
                                          text: some,
                                              // homeController
                                              //         .allpalyers[index]
                                              //         .player!.name!.isNotEmpty
                                              //     ? ' ${homeController.allpalyers[index].player!.name}' 
                                              //     : 'Player ${index + 1} Name',
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Obx(() {
                                              return Checkbox(
                                                value:
                                                    gamesSetupController
                                                        .isGoalkeeperList[index],
                                                onChanged: (bool? value) {
                                                  if (value != null) {
                                                    gamesSetupController
                                                            .isGoalkeeperList[index] =
                                                        value;
                                                    gamesSetupController
                                                        .updateGoalKeepers();
                                                  }
                                                },
                                              );
                                            }),

                                            const Text(
                                              'Goalkeeper',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }),

                            // CustomButton(
                            //   title: "Add Players",
                            //   onPress: () {
                            //     gamesSetupController.addPlayers();
                            //   },
                            // ),
                          ],
                        ),
                      ),

                      // const SizedBox(height: 30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Zone Rotation',
                      //           style: globalTextStyle(
                      //             color: const Color(0xFFABABAB),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         const SizedBox(width: 5),
                      //         Image.asset(
                      //           IconPath.lock,
                      //           height: 12,
                      //           width: 12,
                      //           color: const Color(0xFFABABAB),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           'Position Rotation',
                      //           style: globalTextStyle(
                      //             color: const Color(0xFFABABAB),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         const SizedBox(width: 5),
                      //         Image.asset(
                      //           IconPath.lock,
                      //           height: 12,
                      //           width: 12,
                      //           color: const Color(0xFFABABAB),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 12),
                      // RadioButton(gamesSetupController: gamesSetupController),
                      SizedBox(height: 40),
                      CustomButton(
                        title: 'Calculate Fair Play Time',
                        onPress: () async {
                          await gamesSetupController.gamesetup();
                          Get.toNamed(AppRoute.calculateTime);
                        },
                      ),
                      SizedBox(height: 33),

                      //comment for premium
                      //===============================================================================

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Formation',
                      //       style: globalTextStyle(
                      //         color: Color(0xFFABABAB),
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     SizedBox(width: 5),
                      //     Image.asset(IconPath.lock1, height: 20, width: 20),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // FormationButtonRow2(), // ======================================= formation button row
                      // SizedBox(height: 20),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Image.asset(ImagePath.football, fit: BoxFit.cover),
                      //     // Player 1
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.055,
                      //     ),
                      //     // Player 2
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'RWF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.105,
                      //       right: MediaQuery.of(context).size.height * 0.04,
                      //     ),
                      //     // Player 3
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'LWF',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.105,
                      //       left: MediaQuery.of(context).size.height * 0.04,
                      //     ),
                      //     // Player 4
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'AM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.210,
                      //     ),
                      //     // Player 5
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.310,
                      //       left: MediaQuery.of(context).size.height * 0.07,
                      //     ),
                      //     // Player 6
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       top: MediaQuery.of(context).size.height * 0.310,
                      //       right: MediaQuery.of(context).size.height * 0.08,
                      //     ),
                      //     // Player 7
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'RB',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.190,
                      //       right: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //     // Player 8
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'LB',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.190,
                      //       left: MediaQuery.of(context).size.height * 0.03,
                      //     ),
                      //     // Player 9
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.160,
                      //       left: MediaQuery.of(context).size.height * 0.12,
                      //     ),
                      //     // Player 10
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'CM',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.160,
                      //       right: MediaQuery.of(context).size.height * 0.12,
                      //     ),
                      //     // Player 11
                      //     PlayerSetupWidget(
                      //       playerName: 'Robert',
                      //       playerRole: 'GK',
                      //       profileImagePath: IconPath.profile,
                      //       onEditPressed: () {
                      //         //
                      //       },
                      //       bottom: MediaQuery.of(context).size.height * 0.028,
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Text(
                      //   'Player Rotation',
                      //   style: globalTextStyle(
                      //     color: Color(0xFFABABAB),
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //     border: Border.all(color: Color(0xFFE6EDF7)),
                      //   ),
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.only(bottom: 4),
                      //         child: PlayerRotationRow(
                      //           gamesSetupController: gamesSetupController,
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: 40),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: CustomButton(
                      //         title: 'Reset',
                      //         onPress: () {
                      //           //
                      //         },
                      //         backgroundColor: Colors.white,
                      //         textcolor: Color(0xFF00BA0B),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: CustomButton(
                      //         title: 'Save Changes',
                      //         onPress: () {
                      //           //
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      //=====================================================================================
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
    );
  }
}
