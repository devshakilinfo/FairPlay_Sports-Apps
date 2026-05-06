import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/features/reports_screen/widget/combinebutton_widget.dart';
import 'package:sports_apps/features/reports_screen/widget/goal_widget.dart';
import 'package:sports_apps/features/reports_screen/widget/result_widget.dart';
import 'package:sports_apps/features/reports_screen/widget/share_button_widget.dart';
import 'package:sports_apps/features/reports_screen/widget/show_result_widget.dart';
import '../../games_setup/controller/match_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, double> dataMap = {"My Team": 65, "Opponent": 35};

    final MatchController matchController = Get.put(MatchController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          "Report",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff082B09),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE6F8E7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 54,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: combinebutton(),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: focusedButtonIndex,
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 9),
                    child: Column(
                      children: [
                        if (value == 0)
                          Container(
                            height: 187,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: Color(0xffE6EDF7),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Obx(() {
                              // This will listen to changes in the lastMatchResponse
                              if (matchController.lastMatchResponse.value ==
                                  null) {
                                EasyLoading.show(status: "loading...");
                                return SizedBox.shrink();
                              }
                              EasyLoading.dismiss();
                              var lastMatch =
                                  matchController
                                      .lastMatchResponse
                                      .value!
                                      .lastMatch;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: showresult(lastMatch),
                                        // child: Text("hello"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 37,
                                    width: double.infinity,
                                    child: result(lastMatch),
                                  ),
                                  SizedBox(
                                    height: 37,
                                    width: double.infinity,
                                    child: goal(lastMatch),
                                  ),
                                ],
                              );
                            }),
                          ),
                        if (value == 1)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" Form Not Availabale In This version"),
                            ],
                          ),
                        if (value == 2)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" Stats Not Availabale In This version"),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          sharebutton(),
          Container(height: 75, color: Colors.transparent),
        ],
      ),
    );
  }

  Widget legendItem(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        SizedBox(width: 5),
        Text(text, style: globalTextStyle(fontSize: 12)),
      ],
    );
  }
}
