import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/games_setup/model/group_model.dart';

import '../../../core/urls/endpoint.dart' show Urls;

//
class GamesSetupController extends GetxController {
  var newCalculateTime = <CalculateTimeModel>[].obs;

  // slider time setup
  final RxInt selectedIndex = 6.obs;
  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  final List<String> times = ['30', '40', '50', '60', '70', '80', '90'];
  String getSelectedTime() {
    return times[selectedIndex.value];
  }

  //========================================

  //========================================

  // custom time setup
  final currentTime = RxInt(0);
  void increaseTime() {
    if (currentTime.value < 100) {
      currentTime.value += 5;
    } else {
      Get.snackbar('Warning', 'Maximum time is 100 minutes.');
    }
  }

  void decreaseTime() {
    if (currentTime.value > 0) {
      currentTime.value -= 5;
    } else {
      Get.snackbar('Warning', 'Minimum time is 0 minutes.');
    }
  }

  // create player name and multiple controller

  @override
  void onInit() {
    // gamesetup();

    super.onInit();

    controllers.add(TextEditingController());
    controllers.add(TextEditingController());
    updatePlayerControllers('7 v 7');
  }

  void addPlayers() {
    if (controllers.length < 12) {
      controllers.add(TextEditingController());
      controllers.add(TextEditingController());
    }
  }

  // create button
  var selectedOption = 'Yes'.obs;
  void setOption(String option) {
    selectedOption.value = option;
  }

  var selectedOption1 = 'Yes'.obs;
  void setOption1(String option1) {
    selectedOption1.value = option1;
  }

  var positionRotation = 8.obs;
  var responses = ['Yes', 'No', 'Yes', 'No'].obs;

  // Function to toggle responses
  void toggleResponse(int index) {
    responses[index] = responses[index] == 'Yes' ? 'No' : 'Yes';
    responses.refresh(); // Manually refresh the list
  }

  // Time Allocation ===========
  final List<Map<String, String>> playerData = [
    {"name": "Player-1", "duration": "57 Min", "info": "+0.0"},
    {"name": "Player-2", "duration": "45 Min", "info": "+1.2"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
    {"name": "Player-3", "duration": "60 Min", "info": "-0.5"},
  ];
  var count = 30.obs;
  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  var selectedFormation = '7 v 7'.obs;
  void updateFormation(String formation) {
    selectedFormation.value = formation;
    updatePlayerControllers(formation);
  }

  var isGoalkeeperList = <bool>[].obs;
  var controllers = <TextEditingController>[].obs;

  void updatePlayerControllers(String formation) {
    controllers.clear();
    isGoalkeeperList.clear();

    int numberOfPlayers = 0;
    switch (formation) {
      case '7 v 7':
        numberOfPlayers = 14;
        break;
      case '8 v 8':
        numberOfPlayers = 16;
        break;
      case '9 v 9':
        numberOfPlayers = 18;
        break;
      case '10 v 10':
        numberOfPlayers = 20;
        break;
      case '11 v 11':
        numberOfPlayers = 22;
        break;
      default:
        numberOfPlayers = 14;
    }

    for (int i = 0; i < numberOfPlayers; i++) {
      controllers.add(TextEditingController());
      isGoalkeeperList.add(false);
    }
  }

  var selectedRotaion = '7'.obs;
  void setRotation(String rotation) {
    selectedRotaion.value = rotation;
  }

  var selectedGoalKeeperRotaion = 'No'.obs;
  void setGoalKeeperRotation(String goalKeeperRotation) {
    selectedGoalKeeperRotaion.value = goalKeeperRotation;
  }

  var goalKeeperRotation = false.obs;

  void updateGoalKeeperRotation(String value) {
    goalKeeperRotation.value = value == 'Yes';
  }

  var goalKeepers = <String>[].obs;

  void updateGoalKeepers() {
    goalKeepers.clear();
    for (int i = 0; i < isGoalkeeperList.length; i++) {
      if (isGoalkeeperList[i]) {
        goalKeepers.add(controllers[i].text);
      }
    }
  }

  Future<void> gamesetup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      EasyLoading.show(status: 'Setting up game...');

      final selectedTime = getSelectedTime();
      final playersName =
          controllers
              .where((controller) => controller.text.isNotEmpty)
              .map((controller) => controller.text)
              .toList();

      Map<String, dynamic> requestBody = {
        'rotations': selectedRotaion.value,
        'duration': selectedTime,
        'playersPerRotation': selectedRotaion.value,
        'playersName': playersName,
        'goalKeepers': goalKeepers,
        'goalKeeperRotation': goalKeeperRotation.value,
      };
      debugPrint('[DEBUG] Request body: $requestBody');

      final response = await http.post(
        Uri.parse(Urls.calculator),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken!,
        },
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Game setup successful');
        var resultData = responseData['result'] as List;
        newCalculateTime.value =
            resultData
                .map((data) => CalculateTimeModel.fromJson(data))
                .toList();
      } else {
        EasyLoading.showError(responseData["message"] ?? "Game setup failed");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred");
      debugPrint("Game Setup Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> generatePDF() async {
    if (newCalculateTime.isEmpty) {
      debugPrint("No data available to generate PDF");
      Get.snackbar("Error", "No data available to generate PDF");
      return;
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Game Setup Summary',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              for (var group in newCalculateTime)
                pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(group.timeSegment ?? 'N/A')),
                    pw.Expanded(child: pw.Text(group.duration ?? 'N/A')),
                    pw.Expanded(
                      child: pw.Text(group.activePlayers?.join(', ') ?? 'N/A'),
                    ),
                    pw.Expanded(
                      child: pw.Text(group.restingPlayers?.join(', ') ?? 'N/A'),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    debugPrint('PDF generated and saved!');
  }

  void onSaveAsPressed() async {
    debugPrint('Save As button pressed, generating PDF...');
    await generatePDF();
    debugPrint('PDF generated successfully!');
    EasyLoading.showSuccess("The game setup PDF has been created!");
  }

  Future<void> testPrinting() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                'Printing is working!',
                style: pw.TextStyle(fontSize: 40),
              ),
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      debugPrint('PDF generated and ready for printing!');
    } catch (e) {
      debugPrint('Error during PDF generation: $e');
      Get.snackbar('Error', 'Printing functionality is not available.');
    }
  }
}
