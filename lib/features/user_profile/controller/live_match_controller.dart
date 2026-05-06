import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'dart:convert';

import '../../../core/urls/endpoint.dart';
import '../../home/models/all_player_add_model.dart';
import '../model/live_match_model.dart';

class LiveMatchController extends GetxController {
  var isLoading = true.obs;
  var liveMatches = <LiveMatchModel>[].obs;
  var errorMessage = "".obs;
  var players = <Player>[].obs;
  var selectedPlayer = 'Select Player'.obs;
  var selectedAction = 'Select Action'.obs;
  String? id;

  void setPlayerId(String? id) {
    this.id = id;
  }

  // Function to get the player ID
  String? getPlayerId() {
    return id; // Returns the current player ID, or null if not set
  }

  void setPlayer(String player) {
    selectedPlayer.value = player;
  }

  void setAction(String action) {
    selectedAction.value = action;
  }

  @override
  void onInit() {
    super.onInit();
    fetchLiveMatches();
    fetchLineupPlayers();
  }

  // final String baseUrl =
  //     "https://sports-app-46uo.onrender.com/matches/all-matches"; // Replace with your API base URL

  // Function to fetch live match data
  void fetchLiveMatches() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      // ignore: avoid_print
      print("toke: $token");
      isLoading(true); // Start loading

      // Make the GET request with the header token
      final response = await http.get(
        Uri.parse(Urls.matchByProfileId), // Replace with the correct endpoint
        headers: {'Authorization': '$token'},
      );

      if (response.statusCode == 200) {
        // print(response.body);
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Filter the matches with 'matchStatus' equals 'Live'
        var liveMatchesList =
            data
                .where((match) => match['matchStatus'] == 'Live')
                .map((json) => LiveMatchModel.fromJson(json))
                .toList();

        liveMatches.assignAll(liveMatchesList); // Update liveMatches list
        // print(liveMatches);
      } else {
        // Handle API error response
        throw Exception('Failed to load live match data');
      }
    } catch (e) {
      errorMessage.value = e.toString(); // Capture any error
    } finally {
      isLoading(false); // Stop loading
    }
  }

  Future<void> fetchLineupPlayers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      final response = await http.get(
        Uri.parse(Urls.matchLineupGetLineupPlayers),
        headers: {'Authorization': '$accessToken'}, // Bearer token in header
      );

      if (response.statusCode == 200) {
        List responseData = jsonDecode(response.body)["lineupPlayers"];
        // players.clear(); // Clear existing players list

        // Filter players with 'active' status and add to the list
        for (var playerData in responseData) {
          if (playerData['matchLineupPlayers'] == 'active') {
            players.add(Player.fromJson(playerData));
          }
        }
        // ignore: avoid_print
        print("new Players: $players");
      } else {
        throw Exception('Failed to load players');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> goalsUpate({
    required String matchId,
    required String playerId,
    required String goalsAssets,
  }) async {
    isLoading.value = true;

    try {
      // Retrieve the access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      // Check if the access token is null
      if (accessToken == null) {
        errorMessage.value = 'Access token is missing';
        return false;
      }

      // Set up the request body with matchId, playerId, and goals
      final Map<String, dynamic> body = {
        "matchId": matchId,
        "playerId": playerId,
        goalsAssets: 1, // You can pass the dynamic value here
      };

      // Send the POST request with the Authorization header and body
      final response = await http.post(
        Uri.parse(Urls.matchPlayerStats),
        headers: {
          'Authorization': accessToken, // Add Bearer token to the headers
          'Content-Type':
              'application/json', // Set Content-Type as application/json
        },
        body: jsonEncode(body), // JSON encode the request body
      );

      // Check the status code of the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success Snackbar using GetX
        Get.snackbar(
          'Success',
          'Goals updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        // Handle unsuccessful response
        Get.snackbar(
          'Error',
          'Failed to update goals',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      // Handle any exceptions (network issues, invalid response, etc.)

      return false;
    } finally {
      // Reset loading state after request completes
      isLoading.value = false;
    }
  }
}
