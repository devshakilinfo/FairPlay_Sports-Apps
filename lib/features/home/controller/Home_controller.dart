// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/home/models/all_player_add_model.dart';
import 'package:sports_apps/features/home/screen/games_lineup/model/match_detils_model.dart';
import 'package:sports_apps/routes/app_routes.dart';
import '../../../core/custom_widget/authe_custom_text_feild.dart'
    show AuthCustomTextField;
import '../../../core/custom_widget/custom_button.dart' show CustomButton;
import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class HomeController extends GetxController {
  TextEditingController timeController = TextEditingController();
  TextEditingController opponentTeam = TextEditingController();
  RxList<MatchDetails> matchedetails = <MatchDetails>[].obs;
  RxBool isOpponentTeamVisible = false.obs;
  RxBool isButtonVisible = true.obs;
  RxString selectedTeam = 'FCB'.obs;
  RxString homeorAway = 'Home'.obs;
  var planname1 = ''.obs;

  RxString selectedTime = ''.obs;

  // Function to update the selected time
  void updateSelectedTime(String time) {
    selectedTime.value = time;
  }
  Future<void> fetchprofile() async {
    try {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: 'Loading...');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError('Authentication token not found');
        return;
      }
      debugPrint("----------------$accessToken");
      final response = await http.get(
        Uri.parse(Urls.fetchProfile),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (decodedJson.containsKey("user")) {
          final user = decodedJson["user"];
          final List<dynamic> plans = user["plans"] ?? [];
          final String planName =
              plans.isNotEmpty ? plans.last["name"] : 'No Plan';
          planname1.value = planName;
        } else {
          debugPrint("Error: Missing 'data' in response.");
          EasyLoading.showError('Invalid response format.');
        }
      } else if (response.statusCode == 403) {
        debugPrint("Unauthorized access. Please check your token.");
        EasyLoading.showError('Unauthorized access. Please log in again.');
      } else {
        debugPrint("Error fetching profile: ${response.statusCode}");
        EasyLoading.showError('Failed to fetch profile.');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  //===========================================================

  Future<void> fetchMatches() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError("Authentication token is missing");
        return;
      }
      final url = Urls.matchByProfileId;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<MatchDetails> fetchedMatches =
            data.map((match) => MatchDetails.fromJson(match)).toList();

        // Assign matches to the observable list
        matchedetails.assignAll(fetchedMatches);

        // Get the last match's date and time
        if (fetchedMatches.isNotEmpty) {
          // Assume the last match is the one to use for the countdown
          final lastMatch = fetchedMatches.last;

          // Format the date (ensure it's in the correct format)
          String formattedDate = formatDate(lastMatch.date);

          // Set the formatted date back to the match
          lastMatch.date = formattedDate;

          // Parse the formatted date into DateTime for countdown logic
          DateTime matchDateTime = DateTime.parse(formattedDate);
          lastMatchDateTime = matchDateTime;

          // Call the countdown functionFailed to fetch matches
          startCountdown();
        }
      } else {
        // EasyLoading.showError('Failed to fetch matches');
      }
    } catch (e) {
      EasyLoading.showError('An unexpected error occurred');
    }
  }

  // Format date to 'yyyy-MM-dd' format (removes the time and milliseconds)
  String formatDate(String rawDate) {
    DateTime dateTime = DateTime.parse(rawDate);
    return DateFormat('yyyy-MM-dd').format(dateTime); // Format to '2025-10-19'
  }

  // Time countdown====================================================================================================
  var days = 0.obs;
  var hours = 0.obs;
  var minutes = 0.obs;
  var seconds = 0.obs;
  Timer? _timer;

  DateTime? lastMatchDateTime;

  //==========================================
  void startCountdown() {
    if (lastMatchDateTime != null) {
      // Calculate the remaining time based on the match date
      Duration remainingTime = lastMatchDateTime!.difference(DateTime.now());

      if (remainingTime.isNegative) {
        remainingTime = Duration(seconds: 0);
      }

      days.value = remainingTime.inDays;
      hours.value = remainingTime.inHours % 24;
      minutes.value = remainingTime.inMinutes % 60;
      seconds.value = remainingTime.inSeconds % 60;

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        remainingTime = lastMatchDateTime!.difference(DateTime.now());

        // If the remaining time is negative, stop the countdown and set all to zero
        if (remainingTime.isNegative) {
          remainingTime = Duration(seconds: 0);
          _timer?.cancel();
        }

        // Update the countdown values
        days.value = remainingTime.inDays;
        hours.value = remainingTime.inHours % 24;
        minutes.value = remainingTime.inMinutes % 60;
        seconds.value = remainingTime.inSeconds % 60;
      });
    }
  }

  //=================================================

  @override
  void onInit() {
    super.onInit();
    startCountdown();
    fetchMatches();
    fetchprofile();
    allPlayers();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Future<void> saveChanges() async {
  //   final String location = homeorAway.value;
  //   final String date = selectDate.value;
  //   final String time = timeController.text.trim();
  //   // final String opponentTeam = selectedTeam.value;

  //   final Map<String, dynamic> requestBody = {
  //     "location": location,
  //     "date": date,
  //     "time": selectedTime,
  //     "opponentTeam": opponentTeam,
  //   };

  //   try {
  //     EasyLoading.show(status: 'Saving...');
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? accessToken = prefs.getString('accessToken');
  //     if (accessToken == null) {
  //       EasyLoading.showError("Authentication token is missing");

  //       return;
  //     }

  //     final response = await http.post(
  //       Uri.parse(Urls.createMatch),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': accessToken,
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 201) {
  //       EasyLoading.showSuccess('Match created successfully');
  //     } else {
  //       EasyLoading.showError('Failed to create match: ${response.body}');
  //     }
  //   } catch (e) {
  //     EasyLoading.showError('An error occurred: $e');
  //   }
  // }

  Future<void> saveChanges() async {
    final String location = homeorAway.value;
    final String date = selectDate.value;
    final String time = selectedTime.value;
    final String opponent = opponentTeam.text.trim();

    // Debugging print statements
    debugPrint("Location: $location");
    debugPrint("Date: $date");
    debugPrint("Time: $time");
    debugPrint("Opponent Team: $opponent");

    final Map<String, dynamic> requestBody = {
      "location": location,
      "date": date,
      "time": time,
      "opponentTeam": opponent,
    };

    // Debugging the request body
    debugPrint("Request Body: $requestBody");

    try {
      EasyLoading.show(status: 'Saving...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      // Debugging the access token
      debugPrint("Access Token: $accessToken");

      if (accessToken == null) {
        EasyLoading.showError("Authentication token is missing");
        return;
      }

      final response = await http.post(
        Uri.parse(Urls.createMatch),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode(requestBody),
      );

      // Debugging response status and body
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        EasyLoading.showSuccess('Match created successfully');
      } else {
        EasyLoading.showError('Failed to create match: ${response.body}');
      }
    } catch (e) {
      // Debugging error
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An error occurred: $e');
    }
  }

  void toggleButtonText() {
    isButtonVisible.value = !isButtonVisible.value;
  }

  var selectedAnswer = 'Yes'.obs;
  void updateAnswer(String answer) {
    selectedAnswer.value = answer;
  }

  var selectedPlayers = <String>{}.obs;
  toggleSelection(int index) {
    var playerId = allpalyers[index].player!.id;
    if (selectedPlayers.contains(playerId)) {
      selectedPlayers.remove(playerId);
    } else {
      selectedPlayers.add(playerId!);
    }
  }

  bool get isSaveButtonEnabled => selectedPlayers.isNotEmpty;

  TextEditingController playernameController = TextEditingController();

  // save change step condiotn
  var isSaveButtonClicked = false.obs;
  void onSaveChangesClicked() {
    isSaveButtonClicked.value = true;
    updateLineupStatus();
  }

  void refreshLineupData() {
    allPlayers();
  }

  Future<void> updateLineupStatus() async {
    try {
      EasyLoading.show(status: 'Loading...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken') ?? '';
      List<String> playerIds = selectedPlayers.toList();
      if (playerIds.isEmpty) {
        EasyLoading.showError('No players selected');
        return;
      }
      String url = Urls.updatelineupplayer;
      Map<String, dynamic> body = {"playerIds": playerIds};
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Lineup updated successfully');
        refreshLineupData(); // Call the method to refresh the data
      } else {
        EasyLoading.showError(
          'Failed to update lineup. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      EasyLoading.showError('Error updating lineup: $e');
    }
  }

  var selecteYear = '2025'.obs;
  void updateDate(String date) {
    selecteYear.value = date;
  }

  //home Screen date select
  //=========================================
  var selectDate = 'DD.MM.YYYY'.obs;
  void updateDat(String date) {
    selectDate.value = date;
  }

  //  position and foot selection
  var selectedFoot = 'Left'.obs;
  var selectedPosition = 'CF'.obs;

  void setPreferredFoot(String foot) {
    selectedFoot.value = foot;
  }

  void setPosition(String position) {
    selectedPosition.value = position;
  }

  // selected year
  Future<void> selectYear(BuildContext context) async {
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
      String formattedYear = "${pickedDate.year}";
      updateDate(formattedYear); // Update the date with only the year
    }
  }

  //==================================================================================================
  //==================================================================================================

  //create player controller

  // Function to handle Player creation

  Future<void> createPlayer() async {
    EasyLoading.show(status: 'Adding Player...');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError("Authentication token is missing");
        return;
      }
      Map<String, dynamic> requestBody = {
        'name': playernameController.text.trim(),
        'birthYear': int.parse(selecteYear.value),
        'position': selectedPosition.value,
        'preferredFoot': selectedFoot.value,
      };
      final response = await http.post(
        Uri.parse(Urls.createPlayer),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        EasyLoading.showSuccess("Player Added Successfully");
        // ignore: unused_local_variable
        allPlayers();
        // ignore: unused_local_variable
        final responseData = jsonDecode(response.body);
        clearFields();
      } else if (response.statusCode == 500) {
        EasyLoading.showError(
          "Server error: Failed to create player. Please try again later.",
        );
      } else {
        final responseData = jsonDecode(response.body);
        String errorMessage =
            responseData["message"] ?? "Failed to create player";
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("An error occurred: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void clearFields() {
    playernameController.clear();
    selecteYear.value = '';
    selectedPosition.value = '';
    selectedFoot.value = '';
  }

  // playuer history page controller =======

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double textFontSize = (screenHeight < 700) ? 14 : 16;
        double fontsize = (screenHeight < 700) ? 9 : 12;
        double iconSize = (screenHeight < 700) ? 20 : 32;
        double textWidth = (screenHeight < 700) ? 4 : 12;
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SingleChildScrollView(
            // Ensures scrollable content
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Player Name',
                    style: globalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 10),
                  AuthCustomTextField(
                    controller: playernameController,
                    text: 'Enter name',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Year of birth',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xFF78828A)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectYear(context);
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
                                'Select year',
                                style: globalTextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  selecteYear.value,
                                  style: globalTextStyle(
                                    color: Color(0xFF00BA0B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Position (Optional)',
                              style: globalTextStyle(
                                color: Color(0xFF333333),
                                fontSize: textFontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: textWidth,
                                vertical: 2,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Color(0xFF78828A)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Obx(
                                      () => Expanded(
                                        child: SizedBox(
                                          width: 500,
                                          child: Text(
                                            selectedPosition.value,
                                            style: globalTextStyle(
                                              color: Color(0xFFABABAB),
                                              fontSize: fontsize,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow:
                                                TextOverflow
                                                    .ellipsis, // Handle long text
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    offset: Offset(0, 50),
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: iconSize,
                                      width: iconSize,
                                    ),
                                    onSelected: (String value) {
                                      setPosition(value);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Goal keeper',
                                          child: Text('Goal keeper'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Defender',
                                          child: Text('Defender'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Midfielder',
                                          child: Text('Midfielder'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Attacker',
                                          child: Text('Attacker'),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
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
                              'Preferred foot (Optional)',
                              style: globalTextStyle(
                                color: Color(0xFF333333),
                                fontSize: textFontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: textWidth,
                                vertical: 6,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF78828A)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Text(
                                      selectedFoot.value,
                                      style: globalTextStyle(
                                        color: Color(0xFFABABAB),
                                        fontSize: fontsize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Image.asset(
                                      IconPath.dropdown,
                                      height: iconSize,
                                      width: iconSize,
                                    ),
                                    onSelected: (String value) {
                                      setPreferredFoot(value);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Left',
                                          child: Text('Left'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Right',
                                          child: Text('Right'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Both',
                                          child: Text('Both'),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).viewInsets.bottom > 15 ? 15 : 32,
                  ),
                  CustomButton(
                    title: 'Save Changes',
                    onPress: () {
                      if (playernameController.text.isNotEmpty &&
                          selecteYear.value.isNotEmpty &&
                          selectedPosition.value.isNotEmpty &&
                          selectedFoot.value.isNotEmpty) {
                        createPlayer();
                      } else {
                        EasyLoading.showError("Please fill in all the fields");
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    title: 'Back',
                    onPress: () {
                      Get.back();
                    },
                    backgroundColor: Colors.white,
                    borderColor: Color(0xFF00BA0B),
                    textcolor: Color(0xFF00BA0B),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================================================================================================================
  // ================================================================================================================
  // ================================================================================================================
  // ================================================================================================================
  // ================================================================================================================
  void showprofileDilog(BuildContext context, int index, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = (screenHeight < 700) ? 114 : 125;
        double textFontSize = (screenHeight < 700) ? 8 : 10;
        var filteredPlayers =
            allpalyers
                .where((player) => player.matchLineupPlayers == status)
                .toList();
        var player = filteredPlayers[index];

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImagePath.palyerimage,
                      width: screenWidth,
                      height: 156,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF0047AB),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Image.asset(IconPath.clublogo),
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    player.player!.name ?? 'No Name',
                                    overflow: TextOverflow.ellipsis,
                                    style: globalTextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Real Madrid',
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
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Age',
                                    style: globalTextStyle(
                                      color: Color(0xFF898989),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    (DateTime.now().year -
                                            (player.player!.birthYear ?? 0))
                                        .toString(),

                                    style: globalTextStyle(
                                      color: Color(0xFF1F1F1F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Position',
                                    style: globalTextStyle(
                                      color: Color(0xFF898989),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    player.player!.position ?? 'Center Forward',
                                    style: globalTextStyle(
                                      color: Color(0xFF1F1F1F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Strong Foot',
                              style: globalTextStyle(
                                color: Color(0xFF898989),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              player.player!.preferredFoot ?? "Left",
                              style: globalTextStyle(
                                color: Color(0xFF1F1F1F),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F8E7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appearance',
                              style: globalTextStyle(
                                color: Color(0xFF898989),
                                fontSize: textFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '50',
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F8E7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Goals',
                              style: globalTextStyle(
                                color: Color(0xFF898989),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              player.player!.totalGoals.toString(),
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6F8E7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assist',
                              style: globalTextStyle(
                                color: Color(0xFF898989),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              player.player!.totalAssists.toString(),
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(
                  title: 'View History',
                  onPress: () {
                    Get.toNamed(
                      AppRoute.playerHistory2,
                      arguments: {
                        'filteredPlayers': filteredPlayers,
                        'index': index,
                        'status': status,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var allpalyers = <LineupPlayers>[].obs;
  Future<void> allPlayers() async {
    try {
      EasyLoading.show(status: 'Loading...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken') ?? '';
      if (accessToken.isEmpty) {
        EasyLoading.showError('Authentication token not found');
        return;
      }
      final String url = Urls.allPlayers;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );
      debugPrint("-=-=-=-=-=-=-=-=-=-=${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        debugPrint("-=-=-=-=-=-=-=-=-=-=${response.body}");
        allpalyers.clear();
        final List<dynamic> playerData = responseData['lineupPlayers'] ?? [];
        for (var player in playerData) {
          LineupPlayers lineupPlayerData = LineupPlayers.fromJson(player);
          allpalyers.add(lineupPlayerData);
        }
        EasyLoading.dismiss();
      } else {
        debugPrint("=======${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Error fetching player details: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
//