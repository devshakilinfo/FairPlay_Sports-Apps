import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import '../../../core/custom_widget/custom_button.dart';
import '../../../routes/app_routes.dart' show AppRoute;
import '../controller/subscriptio_plan_controller.dart'
    show SubscriptioPlanController;
import '../widget/basic_package.dart';
import '../widget/basic_package_plus.dart' show BasicPackagePlus;
import '../widget/custom_plan.dart' show CustomPlan;
import '../widget/premium_package.dart' show PremiumPackage;
import '../widget/pro_package.dart' show ProPackage;

// ignore: must_be_immutable
class SubscriptionPlanScreen extends StatelessWidget {
  SubscriptionPlanScreen({super.key});
  SubscriptioPlanController planController = Get.put(
    SubscriptioPlanController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Choose Your Plan',
          style: globalTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SizedBox(
                  height: 123,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: planController.allplanList.length,
                    itemBuilder: (context, index) {
                      final plan = planController.allplanList[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Obx(() {
                          return CustomPlan(
                            package: plan.name ?? 'Unknown',
                            price:
                                planController.isMonthlySelected.value
                                    ? plan.priceMonthly.toString()
                                    : plan.priceYearly.toString(),
                            date:
                                planController.isMonthlySelected.value
                                    ? 'Month'
                                    : 'Year',

                            isselected:
                                planController.isselected.value == plan.name,
                            onTap: () {
                              planController.isselected.value = plan.name ?? '';
                              if (plan.name == "Premium") {
                                premimumMathod(context);
                              } else if (plan.name == "Pro") {
                                proMathod(context);
                              }
                            },
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 32),
              Obx(
                () => Text(
                  planController.isselected.value,
                  style: globalTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (planController.isselected.value == "basic") {
                  return BasicPakage();
                } else if (planController.isselected.value == "basic+") {
                  return BasicPackagePlus();
                } else if (planController.isselected.value == "Premium") {
                  return PremiumPackage();
                } else if (planController.isselected.value == "Pro") {
                  return ProPackage();
                } else {
                  return SizedBox.shrink();
                }
              }),
              SizedBox(height: 44),
              Obx(() {
                if (planController.isselected.value == "basic+" ||
                    planController.isselected.value == "Premium" ||
                    planController.isselected.value == "Pro") {
                  String monthlyPrice = '';
                  String yearlyPrice = '';
                  if (planController.isselected.value == "basic+") {
                    monthlyPrice = "\$10";
                    yearlyPrice = "\$100";
                  } else if (planController.isselected.value == "Premium") {
                    monthlyPrice = "\$20";
                    yearlyPrice = "\$180";
                  } else if (planController.isselected.value == "Pro") {
                    monthlyPrice = "\$20";
                    yearlyPrice = "\$180";
                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          planController.selectMonthly();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                planController.isMonthlySelected.value
                                    ? Color(0xFFE6EDF7)
                                    : Color(0xFFE6EDF7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                IconPath.chack,
                                height: 22,
                                width: 22,
                                color:
                                    planController.isMonthlySelected.value
                                        ? Color(0xFF0047AB)
                                        : Color(0xFFC2D3EB),
                              ),
                              Text(
                                'Monthly Price',
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      planController.isMonthlySelected.value
                                          ? Colors.black
                                          : Color(0xFF898989),
                                ),
                              ),
                              Text(
                                monthlyPrice,
                                style: globalTextStyle(
                                  color:
                                      planController.isMonthlySelected.value
                                          ? Color(0xFF0047AB)
                                          : Color(0xFF91B0DB),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          planController.selectYearly();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                planController.isYearlySelected.value
                                    ? Color(0xFFE6EDF7)
                                    : Color(0xFFE6EDF7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                IconPath.chack,
                                height: 22,
                                width: 22,
                                color:
                                    planController.isYearlySelected.value
                                        ? Color(0xFF0047AB)
                                        : Color(0xFFC2D3EB),
                              ),
                              Text(
                                'Yearly Price',
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      planController.isYearlySelected.value
                                          ? Colors.black
                                          : Color(0xFF898989),
                                ),
                              ),
                              Text(
                                yearlyPrice,
                                style: globalTextStyle(
                                  color:
                                      planController.isYearlySelected.value
                                          ? Color(0xFF0047AB)
                                          : Color(0xFF91B0DB),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
              Obx(
                () => Column(
                  children: [
                    // Jast sized for button
                    planController.isselected.value == "basic"
                        ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.155,
                        )
                        : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.030,
                        ),

                    // button funtion
                    if (planController.isselected.value == "Premium" ||
                        planController.isselected.value == "Pro")
                      SizedBox.shrink()
                    else
                      // Obx(() {
                      //   String planName = planController.isselected.value;
                      //   return
                      //   // CustomButton(
                      //   //   title:
                      //   //       'Start with ${planController.isselected.value}',
                      //   //   onPress: () {
                      //   //     String subscriptionType =
                      //   //         planController.isMonthlySelected.value
                      //   //             ? 'Monthly'
                      //   //             : 'Yearly';
                      //   //     // Get selected plan
                      //   //     var selectedPlan = planController.allplanList
                      //   //         .firstWhere(
                      //   //           (plan) =>
                      //   //               plan.name ==
                      //   //               planController.isselected.value,
                      //   //         );
                      //   //     // Debug print selected plan details
                      //   //     print("Selected Plan: ${selectedPlan.name}");
                      //   //     print("Plan ID: ${selectedPlan.id}");
                      //   //     print("Subscription Type: $subscriptionType");
                      //   //     // Ensure `id` is not null
                      //   //     var selectedPlanId =
                      //   //         selectedPlan.id ??
                      //   //         ''; // Fallback to empty string if `id` is null
                      //   //     print("Using Plan ID: $selectedPlanId");
                      //   //     // Call API for purchase before navigating
                      //   //     planController.purchasePlan(
                      //   //       selectedPlanId,
                      //   //       subscriptionType,
                      //   //     );
                      //   //   },
                      //   // );
                      //   CustomButton(
                      //     title:
                      //         'Start with ${planController.isselected.value}',
                      //     onPress: () {
                      //       String subscriptionType =
                      //           planController.isMonthlySelected.value
                      //               ? 'Monthly'
                      //               : 'Yearly';
                      //       // Get selected plan
                      //       var selectedPlan = planController.allplanList
                      //           .firstWhere(
                      //             (plan) =>
                      //                 plan.name ==
                      //                 planController.isselected.value,
                      //           );
                      //       // Debug print selected plan details
                      //       debugPrint("Selected Plan: ${selectedPlan.name}");
                      //       debugPrint("Plan ID: ${selectedPlan.id}");
                      //       debugPrint("Subscription Type: $subscriptionType");
                      //       // Ensure `id` is not null
                      //       var selectedPlanId =
                      //           selectedPlan.id ??
                      //           ''; // Fallback to empty string if `id` is null
                      //       debugPrint("Using Plan ID: $selectedPlanId");
                      //       // Call API for purchase before navigating
                      //       planController.purchasePlan(
                      //         selectedPlanId,
                      //         subscriptionType,
                      //       );
                      //     },
                      //   );
                      // }),
                      Obx(() {
                        if (planController.isselected.value == "basic") {
                          // If "Basic" is selected, navigate to profile screen
                          return CustomButton(
                            title:
                                'Start with ${planController.isselected.value}',
                            onPress: () {
                              // Navigate to profile screen when Basic is selected
                              Get.toNamed(AppRoute.profileScreen);
                            },
                          );
                        } else {
                          // For other plans, show purchase button or confirm payment button
                          if (planController.isPaymentInProgress.value) {
                            // If payment is in progress, show "Confirm Payment" button
                            return CustomButton(
                              title: 'Confirm Payment',
                              onPress: () {
                                String sessionId =
                                    planController.sessionId.value;
                                if (sessionId.isNotEmpty) {
                                  planController.verifyPayment(sessionId);
                                } else {
                                  EasyLoading.showError('No session ID found');
                                }
                              },
                            );
                          } else {
                            // Otherwise show "Start with plan" button
                            return CustomButton(
                              title:
                                  'Start with ${planController.isselected.value}',
                              onPress: () {
                                String subscriptionType =
                                    planController.isMonthlySelected.value
                                        ? 'Monthly'
                                        : 'Yearly';
                                var selectedPlan = planController.allplanList
                                    .firstWhere(
                                      (plan) =>
                                          plan.name ==
                                          planController.isselected.value,
                                    );
                                var selectedPlanId = selectedPlan.id ?? '';
                                planController.purchasePlan(
                                  selectedPlanId,
                                  subscriptionType,
                                );
                              },
                            );
                          }
                        }
                      }),
                    SizedBox(height: 16),
                    if (planController.isselected.value == "Premium" ||
                        planController.isselected.value == "Pro")
                      SizedBox.shrink()
                    else
                      Obx(() {
                        String planName = planController.isselected.value;
                        return CustomButton(
                          title: 'Skip',
                          onPress: () {
                            Get.toNamed(
                              AppRoute.profileScreen,

                              arguments: planName,
                            );
                          },
                          backgroundColor: Colors.white,
                          textcolor: Color(0xFF00BA0B),
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> premimumMathod(BuildContext context) {
  SubscriptioPlanController planController = Get.put(
    SubscriptioPlanController(),
  );
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Alert",
                  textAlign: TextAlign.center,
                  style: globalTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Image.asset(IconPath.warningicon, height: 24, width: 24),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Premium Package is not available in the app.",
              textAlign: TextAlign.center,
              style: globalTextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  planController.isselected.value = "basic";
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Color(0xff00BA0B),
                ),
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> proMathod(BuildContext context) {
  SubscriptioPlanController planController = Get.put(
    SubscriptioPlanController(),
  );
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Alert",
                  textAlign: TextAlign.center,
                  style: globalTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Image.asset(IconPath.warningicon, height: 24, width: 24),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Pro Package is not available in the app.",
              textAlign: TextAlign.center,
              style: globalTextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  planController.isselected.value = "basic";
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Color(0xff00BA0B),
                ),
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    },
  );
}
