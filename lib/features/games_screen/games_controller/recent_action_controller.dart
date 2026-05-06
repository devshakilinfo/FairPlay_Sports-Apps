import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/games_screen/games_model/recent_action_model.dart';

class RecentActionsController extends GetxController {
  var recentActions = <RecentAction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActions();
  }

  void addAction(RecentAction action) {
    recentActions.add(action);
    saveActions();
  }

  void removeAction(RecentAction action) {
    recentActions.remove(action);
    saveActions();
  }

  void saveActions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> actions = recentActions.map((action) => '${action.playerName}|${action.action}').toList();
    await prefs.setStringList('recentActions', actions);
  }

  void loadActions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? actions = prefs.getStringList('recentActions');
    if (actions != null) {
      recentActions.value = actions.map((action) {
        var parts = action.split('|');
        return RecentAction(playerName: parts[0], action: parts[1]);
      }).toList();
    }
  }
}