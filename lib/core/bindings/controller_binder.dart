

import 'package:get/get.dart';
import 'package:sports_apps/features/user_profile/controller/user_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.lazyPut<UserProfileController>(()=>UserProfileController(),
    fenix: true,
    );

  }
}