import 'package:get/get.dart';

class SettingController extends GetxController {

  var showPrivacyScreen = false.obs;
  var showSecurityScreen = false.obs;
  var showDataPrivacyTermsScreen = false.obs;
  var showTermsAndConditionScreen = false.obs;

  var currentScreenName = 'Settings'.obs;

  void togglePrivacyScreen() {
    showPrivacyScreen.toggle();
    if (!showPrivacyScreen.isTrue) {
      currentScreenName.value = 'Settings';
    }
  }

  void toggleSecurityScreen() {
    showSecurityScreen.toggle();
    if (!showSecurityScreen.isTrue) {
      currentScreenName.value = 'Settings';
    }
  }

  void toggleDataPrivacyTermsScreen() {
    showDataPrivacyTermsScreen.toggle();
    if (!showDataPrivacyTermsScreen.isTrue) {
      currentScreenName.value = 'Settings';
    }
  }

  void toggleTermsAndConditionScreen() {
    showTermsAndConditionScreen.toggle();
    if (!showTermsAndConditionScreen.isTrue) {
      currentScreenName.value = 'Settings';
    }
  }
}
