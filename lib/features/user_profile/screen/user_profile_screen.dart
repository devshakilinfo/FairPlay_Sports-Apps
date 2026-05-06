import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/upgreade_pro_container.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/user_profile/widget/custom_widget.dart';
import 'package:sports_apps/routes/app_routes.dart';

import '../controller/user_profile_controller.dart' show UserProfileController;

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  // UserProfileController userProfileController = Get.put(
  //   UserProfileController(),
  // );
  UserProfileController userProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double textFontSize = (screenHeight < 700) ? 13 : 14;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImagePath.userbackgorund),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 90,
                    left: MediaQuery.of(context).size.width / 2 - 60,

                    child: Obx(() {
                      debugPrint(
                        "==================${userProfileController.logoUrl.value}",
                      );
                      return CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius:
                              58, // Slightly smaller radius for the inner CircleAvatar
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius:
                                56, // Even smaller for the innermost CircleAvatar
                            backgroundImage:
                                userProfileController
                                        .selectedImagePath
                                        .value
                                        .isEmpty
                                    ? (userProfileController
                                            .logoUrl
                                            .value
                                            .isNotEmpty
                                        ? NetworkImage(
                                          userProfileController.logoUrl.value,
                                        )
                                        : AssetImage(ImagePath.profileteam)
                                            as ImageProvider)
                                    : FileImage(
                                      File(
                                        userProfileController
                                            .selectedImagePath
                                            .value,
                                      ),
                                    ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProfileController.clubnameController.text.isEmpty
                      ? 'Adam Jonh'
                      : userProfileController.clubnameController.text,
                  style: globalTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "club",
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff898989),
                  ),
                  textAlign: TextAlign.center,
                ),

                GestureDetector(
                  onTap: () {
                    userProfileController.showImagePicker(context);
                  },
                  child: SizedBox(
                    height: 24,
                    width: 113,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Color(0xff0047AB), size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Edit Logo",
                          style: globalTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0047AB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal Information",
                        style: globalTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          userProfileController.toggleEdit();
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xffE6F8E7),
                          child: Icon(
                            Icons.edit,
                            color: Color(0xff0047AB),
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => Column(
                      children: [
                        CustomTextField(
                          controller: userProfileController.nameController,
                          hintText:
                              userProfileController.nameController.text.isEmpty
                                  ? 'Adam Jonh'
                                  : userProfileController.nameController.text,
                          text: 'Coach Name',
                          enable: userProfileController.isEnable.value,
                        ),

                        SizedBox(height: 9),

                        CustomTextField(
                          controller: userProfileController.clubnameController,
                          hintText:
                              userProfileController
                                      .clubnameController
                                      .text
                                      .isEmpty
                                  ? 'Club Name'
                                  : userProfileController
                                      .clubnameController
                                      .text,
                          text: 'Club Name',
                          enable: userProfileController.isEnable.value,
                        ),
                        SizedBox(height: 9),

                        CustomTextField(
                          controller: userProfileController.emailController,
                          hintText:
                              userProfileController.emailController.text.isEmpty
                                  ? 'Email'
                                  : userProfileController.emailController.text,
                          text: 'Email',
                          enable: userProfileController.isClosed,
                        ),
                        SizedBox(height: 9),

                        CustomTextField(
                          controller: userProfileController.countryController,
                          hintText:
                              userProfileController
                                      .countryController
                                      .text
                                      .isEmpty
                                  ? 'Country'
                                  : userProfileController
                                      .countryController
                                      .text,
                          text: 'Country',
                          enable: userProfileController.isEnable.value,
                        ),

                        SizedBox(height: 9),

                        CustomTextField(
                          controller: userProfileController.cityController,
                          hintText:
                              userProfileController.cityController.text.isEmpty
                                  ? 'City'
                                  : userProfileController.cityController.text,
                          text: 'City',
                          enable: userProfileController.isEnable.value,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                  Obx(
                    () => SizedBox(
                      height: userProfileController.isEnable.value ? 48 : 0,
                      width: double.infinity,
                      child:
                          userProfileController.isEnable.value
                              ? OutlinedButton(
                                onPressed: () async {
                                  await userProfileController.updateProfile();
                                  await userProfileController.profilepicture();
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xFF00BA0B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save & Change",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : SizedBox(),
                    ),
                  ),

                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription Information",
                        style: globalTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 61,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xffE6EDF7), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Plan",
                            style: globalTextStyle(
                              fontSize: textFontSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            userProfileController.planNmae.value,
                            style: globalTextStyle(
                              fontSize: textFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  UpgradeProContainer(onTap: () {
                    Get.toNamed(AppRoute.subscriptionPlanScreen);
                  }),
                  SizedBox(height: 28),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 61,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          userProfileController.logout();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xffE6EDF7),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.logout, color: Colors.red, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
