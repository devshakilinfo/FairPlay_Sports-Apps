import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/games_screen/games_widget.dart/time_widget.dart';

class PlayerHistory2Controller extends GetxController {
  var isLoading = false.obs; // Define the loading state as observable

  Future<void> deletePlayer(String playerId) async {  // Change parameter to playerId
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  
  // Use playerId in the API URL
  final url = 'https://sports-app-2b6y.onrender.com/players/delete-player/$playerId';

  try {
    EasyLoading.show(status: "Deleting player...");
    isLoading.value = true;

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': '$accessToken',
      },
    );

    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Player deleted successfully');
      
      // Remove the player from the local list (optional)
      homeController.allpalyers.removeWhere((player) => player.player?.id == playerId);
      
      Get.back(); // Go back to the previous screen
    } else {
      throw Exception('Failed to delete player: ${response.statusCode}');
    }
  } catch (e) {
    EasyLoading.showError('Error: $e');
  } finally {
    EasyLoading.dismiss();
    isLoading.value = false;
  }
}

}
