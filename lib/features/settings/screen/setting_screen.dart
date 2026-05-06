import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/settings/controller/setting_controller.dart';

import '../widget/setting_model.dart' show SettingModel;

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screen = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_settingController.showPrivacyScreen.isTrue) {
          _settingController.togglePrivacyScreen();
          return false;
        } else if (_settingController.showSecurityScreen.isTrue) {
          _settingController.toggleSecurityScreen();
          return false;
        } else if (_settingController.showDataPrivacyTermsScreen.isTrue) {
          _settingController.toggleDataPrivacyTermsScreen();
          return false;
        } else if (_settingController.showTermsAndConditionScreen.isTrue) {
          _settingController.toggleTermsAndConditionScreen();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () async {
              if (_settingController.showPrivacyScreen.isTrue) {
                _settingController.togglePrivacyScreen();
              } else if (_settingController.showSecurityScreen.isTrue) {
                _settingController.toggleSecurityScreen();
              } else if (_settingController.showDataPrivacyTermsScreen.isTrue) {
                _settingController.toggleDataPrivacyTermsScreen();
              } else if (_settingController
                  .showTermsAndConditionScreen
                  .isTrue) {
                _settingController.toggleTermsAndConditionScreen();
              } else {
                Get.back(); // Go back to the home screen
              }
            },
          ),
          title: Obx(
            () => Text(
              _settingController.currentScreenName.value,
              style: globalTextStyle(
                color: Color(0xFF082B09),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'General',
                      style: globalTextStyle(
                        color: Color(0xFF0047AB),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(IconPath.like, height: 18, width: 18),
                              SizedBox(width: 10),
                              Text(
                                'Leave feedback',
                                style: globalTextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                IconPath.like,
                                height: 18,
                                width: 18,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width < 700
                                        ? 2
                                        : 10,
                              ),
                              SizedBox(
                                width: 290,
                                child: Text(
                                  'Give your feedback about this app write hare',
                                  style: globalTextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SettingModel(
                            text: 'Clear cache',
                            imagePath: IconPath.wrold,
                          ),
                          SizedBox(height: 40),
                          SettingModel(text: 'FAQ', imagePath: IconPath.faq),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: _settingController.toggleSecurityScreen,
                            child: SettingModel(
                              text: 'Security',
                              imagePath: IconPath.security,
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: _settingController.togglePrivacyScreen,
                            child: SettingModel(
                              text: 'Privacy',
                              imagePath: IconPath.lock,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Legal',
                      style: globalTextStyle(
                        fontSize: 20,
                        color: Color(0xFF0047AB),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap:
                                _settingController.toggleDataPrivacyTermsScreen,
                            child: SettingModel(
                              text: 'Data privacy Terms',
                              imagePath: IconPath.document,
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap:
                                _settingController
                                    .toggleTermsAndConditionScreen,
                            child: SettingModel(
                              text: 'Terms and condition',
                              imagePath: IconPath.trams,
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height < 700
                                    ? 100
                                    : 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Obx(
              () =>
                  _settingController.showPrivacyScreen.value
                      ? _buildOverlayScreen(
                        "Privacy Policy",
                        _settingController.togglePrivacyScreen,
                      )
                      : SizedBox.shrink(),
            ),
            // Reactive UI for Security Screen
            Obx(
              () =>
                  _settingController.showSecurityScreen.value
                      ? _buildOverlayScreen(
                        'Security Screen',
                        _settingController.toggleSecurityScreen,
                      )
                      : SizedBox.shrink(),
            ),
            // Reactive UI for Data Privacy Terms Screen
            Obx(
              () =>
                  _settingController.showDataPrivacyTermsScreen.value
                      ? _buildOverlayScreen(
                        'Data Privacy Terms Screen',
                        _settingController.toggleDataPrivacyTermsScreen,
                      )
                      : SizedBox.shrink(),
            ),
            // Reactive UI for Terms and Condition Screen
            Obx(
              () =>
                  _settingController.showTermsAndConditionScreen.value
                      ? _buildOverlayScreen(
                        'Terms and Condition Screen',
                        _settingController.toggleTermsAndConditionScreen,
                      )
                      : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayScreen(String title, VoidCallback onClose) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title == 'Privacy Policy')
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1. Data Collection: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We collect only necessary data, such as user profiles and match details, to enhance your experience. We do not sell or share your personal information with third parties.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2. Usage of Information: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Usage of Information: Your data is used to improve app performance, track fair play statistics, and provide a better experience. We do not use your information for advertising or unrelated purposes.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3. Security Measures: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We implement strict security protocols to protect your data from unauthorized access, loss, or misuse. Your privacy is our top priority.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '4. Third-Party Services: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Our app may use third-party services (e.g., Google Analytics) to improve performance. These services have their own privacy policies, which we encourage you to review.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '5. User Rights: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'You have full control over your data. You can request to edit or delete your account and personal information at any time by contacting our support team.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (title == 'Security Screen')
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1.Data Encryption: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We use industry-standard encryption to protect all user data, ensuring secure storage and transmission of information.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2.Secure Authentication: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Our app implements strong authentication methods to prevent unauthorized access, including password hashing and optional two-factor authentication.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3.Regular Security Updates: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We continuously monitor for vulnerabilities and apply security updates to keep your data safe from threats.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '4.Access Control: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Only authorized personnel have access to sensitive user data, and strict internal policies ensure data confidentiality.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '5. Fraud & Abuse Prevention: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We use automated systems to detect and prevent fraudulent activities, hacking attempts, and any misuse of the platform.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (title == 'Data Privacy Terms Screen')
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1. Data Collection: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We collect only essential user information, such as name, email, and match statistics, to improve app functionality. We do not collect unnecessary or sensitive data.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2. Data Usage: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Your data is used strictly for app-related purposes, including performance tracking, fair play analysis, and user experience improvements. We do not use your data for third-party advertising.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3. Data Storage & Protection: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'All user data is securely stored using encryption and advanced security measures to prevent unauthorized access, data breaches, or loss.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '4. Data Sharing Policy: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We do not sell, trade, or share your personal information with third parties unless required by law or with your explicit consent.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '5. User Rights: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'You have full control over your data. You can request to access, update, or delete your personal information at any time through the app settings or by contacting support.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (title == 'Terms and Condition Screen')
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1. Account Registration: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'Users must provide accurate information during registration. Any misuse, false data, or suspicious activity may result in account suspension.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2. Fair Play Commitment: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                ' All users must follow fair play guidelines while using the app. Any reports of cheating, abusive behavior, or misconduct may lead to penalties or account suspension.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3. Data Usage & Privacy: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'By using this app, you agree to our Privacy Policy regarding data collection, storage, and protection. We do not share personal information without consent.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '4. Intellectual Property: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'All app content, including logos, features, and designs, belongs to the app owner. Unauthorized use, modification, or distribution is prohibited.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black, // Default text color
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '5. Termination of Service: ',
                            style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text:
                                'We reserve the right to suspend or terminate accounts that violate these terms, engage in fraudulent activities, or disrupt the fair play environment.',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
