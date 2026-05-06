import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import '../../../core/urls/endpoint.dart' show Urls;
import '../../home/screen/games_lineup/model/container_model.dart'
    show MatchData;

class GamesController extends GetxController {
   RxString selectedTime = ''.obs;

  // Function to update the selected time
  void updateSelectedTime(String time) {
    selectedTime.value = time;
  }
  var isAddMatchButtonClicked = true.obs;
  var timeTextColor = Color(0xff565656).obs;
  RxBool isGamesOpponentTeamVisible = false.obs;
  RxBool isGamesButtonVisible = true.obs;
  var teamName1TextColor = Color(0xFF898989).obs;
  var teamNameTextColor = Color(0xFF898989).obs;

  var days = '00'.obs;
  var hours = '00'.obs;
  var minutes = '00'.obs;
  var seconds = '00'.obs;
  var date = 'DD/MM/YY'.obs;
  var time = '00:00 AM'.obs;

  Timer? _timer;

  // Initialize countdown timer
  void startCountdown() {
    // Starting values for the countdown
    int remainingDays = int.parse(days.value);
    int remainingHours = int.parse(hours.value);
    int remainingMinutes = int.parse(minutes.value);
    int remainingSeconds = int.parse(seconds.value);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        if (remainingMinutes > 0) {
          remainingMinutes--;
          remainingSeconds = 59;
        } else {
          if (remainingHours > 0) {
            remainingHours--;
            remainingMinutes = 59;
            remainingSeconds = 59;
          } else {
            if (remainingDays > 0) {
              remainingDays--;
              remainingHours = 23;
              remainingMinutes = 59;
              remainingSeconds = 59;
            } else {
              // Countdown finished
              _timer?.cancel();
            }
          }
        }
      }

      // Update the observables
      days.value = remainingDays.toString().padLeft(2, '0');
      hours.value = remainingHours.toString().padLeft(2, '0');
      minutes.value = remainingMinutes.toString().padLeft(2, '0');
      seconds.value = remainingSeconds.toString().padLeft(2, '0');
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }

  void onSaveChangesClicked() {
    isAddMatchButtonClicked.value = false;
    isAddMatchButtonClicked.value = false;
  }

  var iconPath = IconPath.activesheld.obs;
  var teamName = "Name".obs;
  var iconPath1 = IconPath.activesheld.obs;
  var teamName1 = "Name".obs;

  void loadGameDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedImagePath = prefs.getString('imagePath');
    String? savedTeamName = prefs.getString('teamName');
    String? savedImagePath1 = prefs.getString('imagePath1');
    String? savedTeamName1 = prefs.getString('teamName1');
    String? savedDays = prefs.getString('days');
    String? savedHours = prefs.getString('hours');
    String? savedMinutes = prefs.getString('minutes');
    String? savedSeconds = prefs.getString('seconds');
    String? savedDate = prefs.getString('date');
    String? savedTime = prefs.getString('time');

    // If data exists in local storage, update state
    if (savedImagePath != null &&
        savedTeamName != null &&
        savedImagePath1 != null &&
        savedTeamName1 != null) {
      iconPath.value = savedImagePath;
      teamName.value = savedTeamName;
      iconPath1.value = savedImagePath1;
      teamName1.value = savedTeamName1;
    }
    if (savedDays != null) days.value = savedDays;
    if (savedHours != null) hours.value = savedHours;
    if (savedMinutes != null) minutes.value = savedMinutes;
    if (savedSeconds != null) seconds.value = savedSeconds;
    if (savedDate != null) date.value = savedDate;
    if (savedTime != null) time.value = savedTime;
    startCountdown();
  }

  @override
  void onInit() {
    super.onInit();
    loadTimeTextColor();
    loadGameDetails();

    _loadTeamNameTextColor();
    _loadTeamName1TextColor();
    fetchMatch();
  }

  void saveChanges() {
    isGamesOpponentTeamVisible.value = false;
    isGamesButtonVisible.value = true;
  }

  // Method to update the color and save it to SharedPreferences
  void updateTimeTextColor() async {
    timeTextColor.value = Color(0xff0047AB); // New color when button is clicked

    // Save the color to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    prefs.setInt('timeTextColor', timeTextColor.value.value); // Save as integer
  }

  // Load the stored color from SharedPreferences
  void loadTimeTextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColor = prefs.getInt('timeTextColor');
    if (savedColor != null) {
      timeTextColor.value = Color(savedColor);
    }
  }

  void updateTeamNameTextColor() {
    teamNameTextColor.value = Color(0xff1F1F1F); // New color

    // Save the color to SharedPreferences
    _saveTeamNameTextColor();
  }

  void updateTeamName1TextColor() {
    teamName1TextColor.value = Color(0xff1F1F1F); // New color

    // Save the color to SharedPreferences
    _saveTeamName1TextColor();
  }

  void _saveTeamNameTextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    prefs.setInt(
      'teamNameTextColor',
      // ignore: deprecated_member_use
      teamNameTextColor.value.value,
    ); // Save color as integer
  }

  // Save the teamName1 text color to SharedPreferences
  void _saveTeamName1TextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: deprecated_member_use
    prefs.setInt(
      'teamName1TextColor',
      // ignore: deprecated_member_use
      teamName1TextColor.value.value,
    ); // Save color as integer
  }

  void _loadTeamNameTextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColor = prefs.getInt('teamNameTextColor');
    if (savedColor != null) {
      teamNameTextColor.value = Color(savedColor); // Set the saved color
    }
  }

  void _loadTeamName1TextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedColor = prefs.getInt('teamName1TextColor');
    if (savedColor != null) {
      teamName1TextColor.value = Color(savedColor);
    }
  }

  var matches = <MatchData>[].obs;
  Future<void> fetchMatch() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError("Authentication token is missing");
        return;
      }

      final url = Urls.matchByProfileId;
      debugPrint('Fetching matches from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<MatchData> fetchedMatches =
            data.map((match) => MatchData.fromJson(match)).toList();
        matches.assignAll(fetchedMatches);
        for (var match in fetchedMatches) {
          DateTime matchDateTime = MatchData.parseDateTime(match.date);
          Duration remainingTime = matchDateTime.difference(DateTime.now());
        }
        debugPrint('Fetched Matches: ${fetchedMatches.length}');
      } else {
        // EasyLoading.showError('Failed to fetch matches');
      }
    } catch (e) {
      debugPrint('Error fetching matches: $e');
      EasyLoading.showError('An unexpected error occurred');
    }
  }
}
