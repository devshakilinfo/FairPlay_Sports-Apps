// ignore_for_file: file_names
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/urls/endpoint.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

class PaymentCardController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController expiresdateController = TextEditingController();
  TextEditingController cardController = TextEditingController();

  RxBool isConVisible = false.obs;
  var isAddButtonVisible = false.obs;
  var containerList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadState();
    Stripe.publishableKey = 'pk_test_replace_with_your_publishable_key';
    _loadAddButtonVisibility();
    _loadContainers();
  }

  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    isConVisible.value = prefs.getBool('isContainerVisible') ?? false;
  }

  Future<void> replaceButton() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isContainerVisible', true);
    isConVisible.value = true;
  }

  void _loadAddButtonVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAddButtonVisible.value = prefs.getBool('isAddButtonVisible') ?? false;
  }

  void saveAddButtonVisibility(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAddButtonVisible', value);
    isAddButtonVisible.value = value;
  }

  void _loadContainers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int containerCount = prefs.getInt('containerCount') ?? 0;
    for (int i = 0; i < containerCount; i++) {
      containerList.add(_createContainer(i));
    }
  }

  Widget _createContainer(int index) {
    return CreateCard();
  }

  void addNewContainer() async {
    int newIndex = containerList.length;
    containerList.add(_createContainer(newIndex));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('containerCount', containerList.length);
  }

  var isProcessing = false.obs;
  Future<String?> createPaymentMethod() async {
    try {
      // Check if any card details are empty
      if (cardController.text.isEmpty ||
          cvcController.text.isEmpty ||
          expiresdateController.text.isEmpty) {
        debugPrint("Card details are incomplete");
        Get.snackbar('Error', 'Please fill in all card details');
        return null;
      }
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              name:
                  nameController.text.isEmpty
                      ? 'Anonymous'
                      : nameController.text,
              email: "rabbiking00@gmail.com",
            ),
          ),
        ),
      );

      return paymentMethod.id;
    } catch (e) {
      debugPrint("Error creating payment method: $e");
      Get.snackbar('Error', 'Failed to create payment method: $e');
      return null;
    }
  }

  Future<void> makePayment(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    // Ensure accessToken is available before making the request
    if (accessToken == null || accessToken.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Access Token is missing. Please login again."),
          backgroundColor: Colors.red,
        ),
      );
      return; // Early exit if accessToken is not available
    }

    isProcessing.value = true; // Start loading

    // Create payment method
    String? paymentMethodId = await createPaymentMethod();
    if (paymentMethodId == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create payment method"),
          backgroundColor: Colors.red,
        ),
      );
      isProcessing.value = false;
      return;
    }

    String planId = "90fcf430-f1c1-40fc-81e4-1deb36b5f005";
    String duration = "monthly";

    try {
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/users/purchase-plan/$planId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": accessToken,
        },
        body: jsonEncode({
          "duration": duration,
          "currency": "usd",
          "paymentMethodId": paymentMethodId,
        }),
      );
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Payment successful!');
      } else {
        Get.snackbar(
          'Error',
          'Payment failed! Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isProcessing.value = false;
    }
  }
}

// 90fcf430-f1c1-40fc-81e4-1deb36b5f005
class CreateCard extends StatelessWidget {
  const CreateCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenSizeHeight = (screenHeight < 700) ? 110 : 114;
    double sizeBoxHeight = (screenHeight < 700) ? 2.2 : 10;
    return SizedBox(
      height: screenSizeHeight,
      width: 213,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Bank Name",
                      style: globalTextStyle(
                        fontSize: 7.19,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "CREDIT  CARD",
                      style: globalTextStyle(
                        fontSize: 6.29,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: sizeBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(IconPath.cardChip, height: 19.75, width: 44.95),
              ],
            ),
            SizedBox(height: sizeBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "1234 5678 9012 3456",
                  style: globalTextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "User Name",
                      style: globalTextStyle(
                        color: Colors.white,
                        fontSize: 8.09,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "EXPIRES \n       END",
                          style: globalTextStyle(
                            color: Colors.white,
                            fontSize: 4.49,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "12/24",
                          style: globalTextStyle(
                            color: Colors.white,
                            fontSize: 8.99,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
