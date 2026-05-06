import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import '../../navigation_ber/screen/bottom_navigation_ber.dart'
    show BottomNavbar;
import '../controller/team_profile_controller.dart' show TeamProfileController;

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  TeamProfileController teamProfileController = Get.put(
    TeamProfileController(),
  );
  String planName = Get.arguments ?? 'No plan selected';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double textFontSize = (screenHeight < 700) ? 10 : 12;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Profile',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                'Enter Your Club Name',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: teamProfileController.clubnameController,
                text: '',
              ),
              SizedBox(height: 19),
              Text(
                'Enter Your Team Name',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: teamProfileController.teamnameController,
                text: '',
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City',
                          style: globalTextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12),
                        AuthCustomTextField(
                          controller: teamProfileController.cityController,
                          text: 'Dhaka',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Country',
                          style: globalTextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12),
                        AuthCustomTextField(
                          controller: teamProfileController.countryController,
                          text: 'Bangladesh',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Text(
                'Upload Club Logo (Required)',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),

              // GestureDetector(
              //   onTap: () {
              //     teamProfileController.showImagePicker(context);
              //     // teamProfileController.pickImage();
              //   },
              //   child: Obx(
              //     () => DottedBorder(
              //       borderType: BorderType.RRect,
              //       radius: Radius.circular(4),
              //       color: Color(0xFF00BA0B),
              //       strokeWidth: 2,
              //       child: Container(
              //         width: double.infinity,
              //         color: Color(0xFFE6F8E7),
              //         child:
              //             teamProfileController.selectedImage.value != null
              //                 ? Image.file(
              //                   teamProfileController.selectedImage.value,
              //                   height: 100,
              //                   width: 100,
              //                   fit: BoxFit.cover,
              //                 )
              //                 : Padding(
              //                   padding: EdgeInsets.symmetric(
              //                     horizontal: 12,
              //                     vertical: 8,
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Image.asset(
              //                         IconPath.backup,
              //                         height: 32,
              //                         width: 32,
              //                       ),
              //                       SizedBox(height: 8),
              //                       Text(
              //                         'Select File',
              //                         style: globalTextStyle(
              //                           color: Color(0xFF00BA0B),
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                       SizedBox(height: 8),
              //                       Text(
              //                         'Supported formats: JPEG, PNG, SVG',
              //                         style: globalTextStyle(
              //                           color: Color(0xFF898989),
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.w400,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () => teamProfileController.showImagePicker(context),
                child: Obx(
                  () => DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(4),
                    color: Color(0xFF00BA0B),
                    strokeWidth: 2,
                    child: Container(
                      width: double.infinity,
                      color: Color(0xFFE6F8E7),
                      child:
                          teamProfileController.selectedImage != null
                              ? Image.file(
                                teamProfileController.selectedImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                              : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      IconPath.backup,
                                      height: 32,
                                      width: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Select File',
                                      style: globalTextStyle(
                                        color: Color(0xFF00BA0B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Supported formats: JPEG, PNG, SVG',
                                      style: globalTextStyle(
                                        color: Color(0xFF898989),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 43),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coach',
                    style: globalTextStyle(
                      color: Color(0xFF333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Coach Name',
                style: globalTextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              AuthCustomTextField(
                controller: teamProfileController.chocenameController,
                text: 'Enter coach name',
              ),
              // SizedBox(height: 35),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Build your Season Squad',
              //       style: globalTextStyle(
              //         color: Color(0xFF333333),
              //         fontSize: 20,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),
              // AuthCustomTextField(
              //   controller: teamProfileController.fastplayernameController,
              //   text: 'Enter player first name',
              // ),
              // SizedBox(height: 16),
              // Text(
              //   'Year of birth',
              //   style: globalTextStyle(
              //     color: Color(0xFF333333),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4),
              //     border: Border.all(color: Color(0xFF78828A)),
              //   ),
              //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           selectYear(context);
              //         },
              //         child: Image.asset(
              //           IconPath.calendar,
              //           height: 24,
              //           width: 24,
              //         ),
              //       ),
              //       SizedBox(width: 12),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Select year',
              //             style: globalTextStyle(
              //               color: Color(0xff565650),
              //               fontSize: 12,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //           Obx(
              //             () => Text(
              //               teamProfileController.selectedDate.value,
              //               style: globalTextStyle(
              //                 color: Color(0xFF00BA0B),
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Position',
              //             style: globalTextStyle(
              //               color: Color(0xFF333333),
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //           SizedBox(height: 8),
              //           Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(4),
              //               border: Border.all(color: Color(0xFF78828A)),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 12),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Obx(
              //                     () => Text(
              //                       teamProfileController
              //                           .selectedPosition
              //                           .value,
              //                       style: globalTextStyle(
              //                         color: Color(0xFFABABAB),
              //                         fontSize: textFontSize - 1,
              //                         fontWeight: FontWeight.w400,
              //                       ),
              //                     ),
              //                   ),
              //                   PopupMenuButton<String>(
              //                     color: Colors.white,
              //                     icon: Image.asset(
              //                       IconPath.dropdown,
              //                       height: 32,
              //                       width: 32,
              //                     ),
              //                     onSelected: (String value) {
              //                       teamProfileController.setPosition(value);
              //                     },
              //                     itemBuilder: (BuildContext context) {
              //                       return <PopupMenuEntry<String>>[
              //                         PopupMenuItem<String>(
              //                           value: 'CF',
              //                           child: Text('CF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'CB',
              //                           child: Text('CB'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'CMF',
              //                           child: Text('CMF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'SS',
              //                           child: Text('Gk'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'LB',
              //                           child: Text('LB'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'RB',
              //                           child: Text('RB'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'RMF',
              //                           child: Text('RWF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'AMF',
              //                           child: Text('AMF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'DMF',
              //                           child: Text('DMF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'LWF',
              //                           child: Text('LWF'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'LMF',
              //                           child: Text('LMF'),
              //                         ),
              //                       ];
              //                     },
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(width: 12),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Preferred foot',
              //             style: globalTextStyle(
              //               color: Color(0xFF333333),
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //           SizedBox(height: 8),
              //           Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(4),
              //               border: Border.all(color: Color(0xFF78828A)),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 12),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Obx(
              //                     () => Text(
              //                       teamProfileController.selectedFoot.value,
              //                       style: globalTextStyle(
              //                         color: Color(0xFFABABAB),
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w400,
              //                       ),
              //                     ),
              //                   ),
              //                   PopupMenuButton<String>(
              //                     color: Colors.white,
              //                     icon: Image.asset(
              //                       IconPath.dropdown,
              //                       height: 32,
              //                       width: 32,
              //                     ),
              //                     onSelected: (String value) {
              //                       teamProfileController.setFoot(value);
              //                     },
              //                     itemBuilder: (BuildContext context) {
              //                       return <PopupMenuEntry<String>>[
              //                         PopupMenuItem<String>(
              //                           value: 'Left',
              //                           child: Text('Left'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'Right',
              //                           child: Text('Right'),
              //                         ),
              //                         PopupMenuItem<String>(
              //                           value: 'Both',
              //                           child: Text('Both'),
              //                         ),
              //                       ];
              //                     },
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 16),

              //skip for now
              //=====================================
              // GestureDetector(
              //   onTap: () {
              //     //
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(4),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.shade700,
              //           spreadRadius: 0.4,
              //           blurRadius: 1,
              //           offset: Offset(0, 1),
              //         ),
              //       ],
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Image.asset(
              //           IconPath.add,
              //           height: 20,
              //           width: 20,
              //           color: Color(0xFF00BA0B),
              //         ),
              //         SizedBox(width: 10),
              //         Text(
              //           'Add Player',
              //           style: globalTextStyle(
              //             color: Color(0xFF082B09),
              //             fontSize: 14,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16),
              CustomButton(
                title: 'Save Changes',
                onPress: () {
                  teamProfileController.createProfile();
                  // teamProfileController.uploadProfilePicture();
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                title: 'Skip',
                backgroundColor: Colors.white,
                textcolor: Color(0xFF00BA0B),
                onPress: () {
                  Get.to(BottomNavbar(), arguments: planName);
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectYear(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF00BA0B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = "${pickedDate.year}";
      teamProfileController.updateDate(formattedDate);
    }
  }
}
