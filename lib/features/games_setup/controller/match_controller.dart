import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'dart:convert';

import '../model/last_match_response.dart';

// Controller for managing match data
class MatchController extends GetxController {
  var lastMatchResponse = Rxn<LastMatchResponse>();

  @override
  void onInit() {
    fetchLastMatch();
    super.onInit();
  }

  // Fetch data from API with header token
  Future<void> fetchLastMatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    final headers = {'Authorization': "$accessToken"};

    try {
      final response = await http.get(
        Uri.parse(Urls.matchRepot),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        lastMatchResponse.value = LastMatchResponse.fromJson(jsonResponse);
        // ignore: avoid_print
        print(response.body);
      } else {
        // Handle error
        // ignore: avoid_print
        print('Failed to load match data');
      }
    } catch (e) {
      // Handle exception
      // ignore: avoid_print
      print('Error: $e');
    }
  }
}
