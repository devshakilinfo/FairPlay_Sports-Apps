import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/features/navigation_ber/screen/bottom_navigation_ber.dart';

class TeamProfileController extends GetxController {
  TextEditingController clubnameController = TextEditingController();
  TextEditingController teamnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController chocenameController = TextEditingController();
  TextEditingController fastplayernameController = TextEditingController();

  var selectedPosition = 'Choose option'.obs;
  var selectedFoot = 'Left'.obs;

  void setPosition(String position) {
    selectedPosition.value = position;
  }

  void setFoot(String foot) {
    selectedFoot.value = foot;
  }

 

  // Future<void> uploadProfilePicture() async {
  //   try {
  //     EasyLoading.show(status: "Uploading...");
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('accessToken');

  //     if (selectedImage.value == null) {
  //       EasyLoading.showError("No image selected!");
  //       return;
  //     }

  //     File file = selectedImage.value!;
  //     if (!file.existsSync()) {
  //       EasyLoading.showError("File does not exist at the selected path.");
  //       return;
  //     }

  //     String extension = file.path.split('.').last.toLowerCase();
  //     if (!['jpg', 'jpeg', 'png'].contains(extension)) {
  //       EasyLoading.showError("Only .jpg, .jpeg, or .png images are allowed.");
  //       return;
  //     }

  //     if (token == null || token.isEmpty) {
  //       EasyLoading.showError("Invalid Token!");
  //       return;
  //     }

  //     String fileName = file.path.split('/').last;
  //     var request = http.MultipartRequest('PUT', Uri.parse(Urls.updateLogo));
  //     request.headers.addAll({
  //       'Authorization': token,
  //       'Content-Type': 'multipart/form-data',
  //     });

  //     var multipartFile = await http.MultipartFile.fromPath(
  //       'logo',
  //       file.path,
  //       filename: fileName,
  //       contentType: MediaType('image', extension),
  //     );
  //     request.files.add(multipartFile);

  //     var response = await request.send();
  //     if (response.statusCode == 201) {
  //       EasyLoading.showSuccess("Profile picture updated successfully");
  //     } else {
  //       EasyLoading.showError("Failed to update profile picture");
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Error occurred: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }



  Future<void> profilepicture() async {
    try {
      EasyLoading.show(status: "Uploading...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      debugPrint("Selected Image Path: ${selectedImagePath.value}");
      if (selectedImagePath.value.isEmpty) {
        EasyLoading.showError("No image selected!");
        return;
      }
      File file = File(selectedImagePath.value);
      if (!file.existsSync()) {
        EasyLoading.showError("File does not exist at the selected path.");
        debugPrint("File does not exist: ${selectedImagePath.value}");
        return;
      }
      String extension = selectedImagePath.value.split('.').last.toLowerCase();
      debugPrint("File Extension: $extension");
      if (!['jpg', 'jpeg', 'png'].contains(extension)) {
        EasyLoading.showError("Only .jpg, .jpeg, or .png images are allowed.");
        return;
      }
      debugPrint("Authorization Token: $token");
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Invalid Token!");
        return;
      }
      String fileName = selectedImagePath.value.split('/').last;
      var request = http.MultipartRequest('POST', Uri.parse(Urls.createProfile));
      request.headers.addAll({
        'Authorization': token,
        'Content-Type': 'multipart/form-data',
      });

      var multipartFile = await http.MultipartFile.fromPath(
        'logo',
        selectedImagePath.value,
        filename: fileName,
        contentType: MediaType('image', extension),
      );
      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 201) {
        EasyLoading.showSuccess("Profile picture updated successfully");
        
      } else {
        EasyLoading.showError("Failed to update profile picture");
        debugPrint("Response status: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Error occurred: $e");
      debugPrint("Exception: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }


  //  var selectedImage = Rx<File?>(null);
  final ImagePicker _imagePicker = ImagePicker();

  // Future<void> pickImage(ImageSource source) async {
  //   try {
  //     final XFile? pickedFile = await _imagePicker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       selectedImagePath.value = pickedFile.path;
  //     } else {
  //       Get.snackbar("No Image Selected", "Please select an image.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to pick an image: $e");
  //   }
  // }

  // var selectedImagePath = ''.obs;

  File getSelectedImage() {
    return File(selectedImagePath.value);
  }

 void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Choose from Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_outlined),
              title: Text('Choose from Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  

  // calender picker ===============
  var selectedDate = '2000'.obs;
  void updateDate(String date) {
    selectedDate.value = date;
  }

  // Future<void> createProfile() async {
  //   EasyLoading.show(status: 'Updating profile...');
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? accessToken = prefs.getString('accessToken');

  //     if (accessToken == null || accessToken.isEmpty) {
  //       EasyLoading.showError("User not authenticated. Please log in again.");
  //       return;
  //     }
  //     Map<String, String> headers = {
  //       "Content-Type": "application/json",
  //       "Authorization": accessToken,
  //     };
  //     Map<String, dynamic> body = {
  //       'clubName': clubnameController.text.trim(),
  //       'teamName': teamnameController.text.trim(),
  //       'city': cityController.text.trim(),
  //       'country': countryController.text.trim(),
  //       'coachName': chocenameController.text.trim(),
  //       'players': [
  //         {
  //           'name': fastplayernameController.text.trim(),
  //           'birthYear': int.parse(selectedDate.value),
  //           'position': selectedPosition.value,
  //           'preferredFoot': selectedFoot.value,
  //         },
  //       ],
  //     };
  //     String jsonBody = json.encode(body);
  //     final response = await http.post(
  //       Uri.parse(Urls.createProfile),
  //       headers: headers,
  //       body: jsonBody,
  //     );
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       profilepicture();
  //       Get.offAll(BottomNavbar());
  //       EasyLoading.showSuccess("Profile updated successfully!");
  //     } else {
  //       EasyLoading.showError("Failed to update profile: ${response.body}");
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       EasyLoading.showError(
  //         "Network error: Please check your internet connection.",
  //       );
  //     } else if (e is HttpException) {
  //       EasyLoading.showError("HTTP error: ${e.message}");
  //     } else {
  //       EasyLoading.showError("An unexpected error occurred: $e");
  //     }
  //     debugPrint("❌ Exception: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }




  
  // ... existing controllers ...

  // Change this to use RxString for path instead of File
  var selectedImagePath = ''.obs;
  File? get selectedImage => selectedImagePath.value.isNotEmpty 
      ? File(selectedImagePath.value) 
      : null;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  Future<void> createProfile() async {
  debugPrint("====== [START] createProfile() ======");
  EasyLoading.show(status: 'Creating profile...');
  debugPrint("[1] EasyLoading shown with 'Creating profile...'");

  try {
    debugPrint("[2] Getting SharedPreferences instance...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("[3] SharedPreferences obtained successfully");

    debugPrint("[4] Retrieving access token...");
    String? accessToken = prefs.getString('accessToken');
    debugPrint("[5] Access Token: ${accessToken ?? 'NULL'}");

    if (accessToken == null) {
      debugPrint("[6] ERROR: No access token found - user not authenticated");
      EasyLoading.showError("Not authenticated");
      return;
    }

    debugPrint("[7] Creating MultipartRequest to: ${Urls.createProfile}");
    var request = http.MultipartRequest('POST', Uri.parse(Urls.createProfile));
    debugPrint("[8] Request object created successfully");

    debugPrint("[9] Setting authorization header...");
    request.headers['Authorization'] = accessToken;
    debugPrint("[10] Headers set: ${request.headers}");

    // Image handling
    if (selectedImagePath.value.isNotEmpty) {
      debugPrint("[11] Image selected at path: ${selectedImagePath.value}");
      debugPrint("[12] Checking image file existence...");
      File imageFile = File(selectedImagePath.value);
      debugPrint("[13] File exists: ${imageFile.existsSync()}");
      debugPrint("[14] File size: ${imageFile.lengthSync()} bytes");
      
      debugPrint("[15] Getting file extension...");
      String extension = imageFile.path.split('.').last.toLowerCase();
      debugPrint("[16] Detected extension: $extension");

      debugPrint("[17] Preparing multipart file upload...");
      var multipartFile = await http.MultipartFile.fromPath(
        'logo',
        imageFile.path,
        contentType: MediaType('image', extension),
      );
      debugPrint("[18] Multipart file prepared successfully");

      debugPrint("[19] Adding file to request...");
      request.files.add(multipartFile);
      debugPrint("[20] File added to request. Total files: ${request.files.length}");
    } else {
      debugPrint("[11] No image selected - skipping file upload");
    }

    // Profile data preparation
    debugPrint("[21] Preparing profile data...");
    Map<String, dynamic> profileData = {
      'clubName': clubnameController.text.trim(),
      'teamName': teamnameController.text.trim(),
      'city': cityController.text.trim(),
      'country': countryController.text.trim(),
      'coachName': chocenameController.text.trim(),
    };
    debugPrint("[22] Profile data prepared: $profileData");

    debugPrint("[23] Converting profile data to JSON...");
    String jsonData = json.encode(profileData);
    debugPrint("[24] JSON data: $jsonData");

    debugPrint("[25] Adding JSON data to 'data' field...");
    request.fields['data'] = jsonData;
    debugPrint("[26] Request fields: ${request.fields}");

    debugPrint("[27] Total files to upload: ${request.files.length}");
    debugPrint("[28] Total fields: ${request.fields.length}");

    debugPrint("[29] Sending request to server...");
    var response = await request.send();
    debugPrint("[30] Request sent. Response status code: ${response.statusCode}");

    debugPrint("[31] Reading response stream...");
    final respStr = await response.stream.bytesToString();
    debugPrint("[32] Full response: $respStr");

    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint("[33] SUCCESS: Profile created successfully");
      debugPrint("[34] Navigating to BottomNavbar...");
      Get.offAll(BottomNavbar());
      EasyLoading.showSuccess("Profile created successfully!");
    } else {
      debugPrint("[35] ERROR: Server returned status ${response.statusCode}");
      try {
        final errorData = json.decode(respStr);
        debugPrint("[36] Error details: $errorData");
        String errorMessage = errorData['error'] ?? errorData['message'] ?? 'Unknown error';
        debugPrint("[37] Displaying error: $errorMessage");
        EasyLoading.showError("Failed: $errorMessage");
      } catch (e) {
        debugPrint("[38] ERROR parsing error response: $e");
        EasyLoading.showError("Failed with status: ${response.statusCode}");
      }
    }
  } catch (e, stackTrace) {
    debugPrint("[39] EXCEPTION OCCURRED: ${e.toString()}");
    debugPrint("[40] STACK TRACE:\n$stackTrace");
    EasyLoading.showError("Error: ${e.toString()}");
  } finally {
    debugPrint("[41] Finalizing operation...");
    EasyLoading.dismiss();
    debugPrint("====== [END] createProfile() ======");
  }
}

}
