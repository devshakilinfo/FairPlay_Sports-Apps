import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/features/authentication/presentation/screens/login_screen.dart';

import '../../../core/urls/endpoint.dart' show Urls;
import '../model/profile_model.dart' show UserData;

class UserProfileController extends GetxController {
  var profileList = <UserData>[].obs;
  var selectedImagePath = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController clubnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();

  var isEnable = false.obs;
  final logoUrl = ''.obs;
  var clubName = ''.obs;
  final RxString planNmae = ''.obs;

  void toggleEdit() {
    isEnable.value = !isEnable.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchprofile();
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      } else {
        Get.snackbar("No Image Selected", "Please select an image.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick an image: $e");
    }
  }

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
      var request = http.MultipartRequest('PUT', Uri.parse(Urls.updateLogo));
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
        fetchprofile();
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

  Future<void> fetchprofile() async {
    try {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: 'Loading...');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError('Authentication token not found');
        return;
      }
      debugPrint("----------------$accessToken");
      final response = await http.get(
        Uri.parse(Urls.fetchProfile),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        if (decodedJson.containsKey("user")) {
          final user = decodedJson["user"];
          final String name = user["coachName"] ?? '';
          final String clubName = user["clubName"] ?? '';
          final String email = user["email"] ?? '';
          final String country = user["country"] ?? '';
          final String city = user["city"] ?? '';
          final String logoUrl = user["logoUrl"] ?? '';
          final List<dynamic> plans = user["plans"] ?? [];
          final String planName = plans.isNotEmpty ? plans.last["name"] : 'No Plan';

          this.clubName.value = clubName;
          planNmae.value = planName;
          

          nameController.text = name;
          clubnameController.text = clubName;
          emailController.text = email;
          countryController.text = country;
          cityController.text = city;
          planNameController.text = planName;
          this.logoUrl.value = logoUrl;
        } else {
          debugPrint("Error: Missing 'data' in response.");
          EasyLoading.showError('Invalid response format.');
        }
      } else if (response.statusCode == 403) {
        debugPrint("Unauthorized access. Please check your token.");
        EasyLoading.showError('Unauthorized access. Please log in again.');
      } else {
        debugPrint("Error fetching profile: ${response.statusCode}");
        EasyLoading.showError('Failed to fetch profile.');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateProfile() async {
    try {
      EasyLoading.show(status: 'Saving changes...');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) {
        EasyLoading.showError('Authentication token not found');
        return;
      }

      final Map<String, dynamic> requestBody = {
        'coachName': nameController.text,
        'clubName': clubnameController.text,
        'email': emailController.text,
        'country': countryController.text,
        'city': cityController.text,
      };

      debugPrint('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse(Urls.updateProfile),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Profile updated successfully');
        toggleEdit();
      } else if (response.statusCode == 403) {
        EasyLoading.showError('Unauthorized access. Please log in again.');
      } else {
        EasyLoading.showError('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      EasyLoading.showError('An unexpected error occurred.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('planName');
    Get.offAll(() => LoginScreen());
  }
}
