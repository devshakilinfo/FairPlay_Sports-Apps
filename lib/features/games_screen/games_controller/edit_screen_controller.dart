import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';

class EditScreenController extends GetxController {
  var players = <Players>[].obs;
  var selectedPlayer =
      'Select Player'.obs; // Observable variable for selected player
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var selectedAction =
      'Select Action'.obs; // Observable variable for selected action

  // Observable variables for matchId, playerId, and goalsAssets
  var matchId = ''.obs;
  var playerId = ''.obs;
  var goalsAssets = ''.obs;

  // Method to update the selected action
  void setAction(String action) {
    selectedAction.value = action; // Update the action
  }

  // Set selected player
  void setSelectedPlayer(String name) {
    selectedPlayer.value = name;
  }

  @override
  void onInit() {
    super.onInit();
    fetchLineupPlayers();
  }

  // Set matchId
  void setMatchId(String id) {
    matchId.value = id;
  }

  // Set playerId
  void setPlayerId(String id) {
    playerId.value = id;
  }

  // Set goalsAssets
  void setGoalsAssets(String goals) {
    goalsAssets.value = goals;
  }

  // Fetch players from API and filter only active players

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
        players.clear(); // Clear existing players list

        // Filter players with 'active' status and add to the list
        for (var playerData in responseData) {
          if (playerData['matchLineupPlayers'] == 'active') {
            players.add(Players.fromJson(playerData));
          }
        }
      } else {
        throw Exception('Failed to load players');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> createPlayersStates() async {
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
        "matchId": matchId.value,
        "playerId": playerId.value,
        goalsAssets.value: 1, // You can pass the dynamic value here
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
        // ignore: avoid_print
        print('Response body: ${response.body}');
        return true;
      } else {
        // Handle unsuccessful response

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

class Players {
  final String id;
  final String name;
  final String position;
  final String profileId;

  Players({
    required this.id,
    required this.name,
    required this.position,
    required this.profileId,
  });

  // Factory method to create a Player object from the API response
  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
      id: json['player']['id'] ?? '',
      name: json['player']['name'] ?? '',
      position: json['player']['position'] ?? '',
      profileId: json['player']['profileId'] ?? '',
    );
  }
}
