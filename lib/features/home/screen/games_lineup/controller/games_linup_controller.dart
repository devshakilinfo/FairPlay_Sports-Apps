import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import '../model/container_model.dart';

class GamesLinupController extends GetxController {
  var matches = <MatchData>[].obs;
  var countdowns = <Rx<Duration>>[].obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }

  @override
  void onReady() {
    super.onReady();
    _startCountdown();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  //===================================================
  Future<void> fetchMatches() async {
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

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<MatchData> fetchedMatches =
            data.map((match) => MatchData.fromJson(match)).toList();

        matches.assignAll(fetchedMatches);

        countdowns.clear();
        for (var match in fetchedMatches) {
          DateTime matchDateTime = MatchData.parseDateTime(match.date);
          Duration remainingTime = matchDateTime.difference(DateTime.now());
          countdowns.add(remainingTime.obs);
        }
        debugPrint('Fetched Matches: ${fetchedMatches.length}');
      } else {
        debugPrint('Failed to fetch matches: ${response.statusCode}');
        // EasyLoading.showError('Failed to fetch matches');
      }
    } catch (e) {
      debugPrint('Error fetching matches: $e');
      EasyLoading.showError('An unexpected error occurred');
    }
  }

  //==========================================

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      for (int i = 0; i < countdowns.length; i++) {
        Duration remainingTime = countdowns[i].value;

        remainingTime = remainingTime - Duration(seconds: 1);
        countdowns[i].value = remainingTime;

        if (remainingTime.isNegative) {
          _timer.cancel();
        }
      }
    });
  }

  String formatTime(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes % 60;
    final int seconds = duration.inSeconds % 60;
    final int days = duration.inDays;

    return '$days Days $hours Hours $minutes Min $seconds Sec';
  }
}
