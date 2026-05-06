import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/home/models/live_match_recent_action_model.dart';

class ProgressController extends GetxController {
  RxDouble progress = 0.0.obs;
  RxString progressName = "Game Starting...".obs;
  RxInt elapsedMinutes = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadProgress();
    _startAutoProgress();
  }

  // Start the auto progress
  void _startAutoProgress() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (elapsedMinutes.value < 60) {
        elapsedMinutes.value++;
        progress.value = elapsedMinutes.value / 60.0; // Update progress
        progressName.value =
            "Played ${elapsedMinutes.value} minute(s)"; // Update progress text

        // When the progress reaches 100%, set the name to "Played"
        if (elapsedMinutes.value == 60) {
          progressName.value = "Played 60 minutes!";
        }

        _saveProgress();
      } else {
        _timer?.cancel(); // Stop the timer once 60 minutes are completed
      }
    });
  }

  // Load saved progress from SharedPreferences
  void _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    elapsedMinutes.value = prefs.getInt('elapsedMinutes') ?? 0;
    progress.value = elapsedMinutes.value / 60.0;
    progressName.value = "Played $elapsedMinutes minute(s)";
  }

  // Save progress to SharedPreferences
  void _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('elapsedMinutes', elapsedMinutes.value);
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.onClose();
  }

  RxString selectedDuration = 'Duration'.obs; // Use RxString for reactive types
  RxString selectedRotation = 'Rotation'.obs;

  void setDuration(String duration) {
    selectedDuration.value = duration;
  }

  void setRotation(String rotation) {
    selectedRotation.value = rotation;
  }
}

class LiveMatchRecentActionsController extends GetxController {
  var recentActions = <LiveMatchRecentAction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActions();
  }

  void addAction(LiveMatchRecentAction action) {
    recentActions.add(action);
    saveActions();
  }

  void removeAction(LiveMatchRecentAction action) {
    recentActions.remove(action);
    saveActions();
  }

  void saveActions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> actions =
        recentActions
            .map((action) => '${action.playerName}|${action.action}')
            .toList();
    await prefs.setStringList('recentActions', actions);
  }

  void loadActions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? actions = prefs.getStringList('recentActions');
    if (actions != null) {
      recentActions.value =
          actions.map((action) {
            var parts = action.split('|');
            return LiveMatchRecentAction(
              playerName: parts[0],
              action: parts[1],
              type: '',
            );
          }).toList();
    }
  }
}
