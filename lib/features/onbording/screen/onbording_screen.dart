import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/custom_button.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/colors.dart';
import 'package:sports_apps/core/utils/constants/image_path.dart';
import 'package:sports_apps/features/onbording/screen/welcome_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController pageController = PageController();
  final PageControllerController controller = Get.put(
    PageControllerController(),
  );

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ever(controller.currentPage, (int index) {
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              controller.changePage(index);
            },
            children: [Page1(), Page2(), Page3()],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            WelcomeScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFE6EDF7),
                          ),
                          child: Center(
                            child: Text(
                              'Skip',
                              style: globalTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 10,
                      width: controller.currentPage.value == index ? 10 : 10,
                      decoration: BoxDecoration(
                        color:
                            controller.currentPage.value == index
                                ? Color(0xFF0047AB)
                                : Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
            ],
          ),
          Positioned(
            bottom: 36,
            left: 20,
            right: 20,
            child: CustomButton(
              title: 'Get Started',
              onPress: () {
                Get.to(WelcomeScreen(), transition: Transition.rightToLeft);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PageControllerController extends GetxController {
  var currentPage = 0.obs;
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    _startAutoPageChange();
  }

  void _startAutoPageChange() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentPage.value < 2) {
        currentPage.value = currentPage.value + 1;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void changePage(int index) {
    currentPage.value = index;
    if (index == 2) {
      _timer?.cancel();
      Timer(Duration(seconds: 3), () {
        Get.to(WelcomeScreen(), transition: Transition.rightToLeft);
      });
    }
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.asset(ImagePath.onboring1, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Fair Play',
                  style: globalTextStyle(
                    fontSize: 24,
                    color: AppColors.buttoncolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Easily manage lineups, substitutions &\n'
                  'equal playing time for young footballers!',
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.asset(ImagePath.onbording2, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Easy Coaching',
                  style: globalTextStyle(
                    fontSize: 24,
                    color: AppColors.buttoncolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Easily manage lineups, substitutions &\n'
                  'equal playing time for young footballers!',
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.asset(ImagePath.onbording3, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Smart Substitutions',
                  style: globalTextStyle(
                    fontSize: 24,
                    color: AppColors.buttoncolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Easily manage lineups, substitutions &\n'
                  'equal playing time for young footballers!',
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
