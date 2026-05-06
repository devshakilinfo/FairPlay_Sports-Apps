import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';

import '../model/match_new_model.dart';

class MatchDataController extends GetxController {
  // Observable list to store the matches
  var matchList = <MatchNewModel>[].obs;
  // Boolean to track if the data is loading
  var isLoading = true.obs;

  // URL for your API endpoint
  final String apiUrl =
      Urls.matchByProfileId;

  @override
  void onInit() {
    super.onInit();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    try {
      EasyLoading.show(status: "loading...");
      // Set isLoading to true before making the API call
      isLoading.value = true;
      Map<String, String> headers = {
        'Authorization': '$accessToken', // Add the token here
        // 'Content-Type': 'application/json', // Optional: depending on your API
      };
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Update the matchList with the parsed data
        matchList.value =
            data.map((matchJson) => MatchNewModel.fromJson(matchJson)).toList();
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching matches: $e');
    } finally {
      EasyLoading.dismiss();
      // Set isLoading to false once the data is fetched or an error occurs
      isLoading.value = false;
    }
  }
}
