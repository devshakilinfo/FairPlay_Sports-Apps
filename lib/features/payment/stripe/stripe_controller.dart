import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sports_apps/features/payment/stripe/stripe_service.dart';

class PaymentController extends GetxController {
  var paymentIntent = Rxn<Map<String, dynamic>>();

  get isConVisible => null;

  Future<void> createPaymentIntent() async {
    try {
      String amount = "80";
      String currency = "USD";

      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var secretKey = stripeSecretKey;

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        paymentIntent.value = jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in Payment Intent: ${e.toString()}');
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
      );
    }
  }

  Future<void> makePayment() async {
    try {
      await createPaymentIntent();

      if (paymentIntent.value != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent.value!['client_secret'],
            googlePay: const PaymentSheetGooglePay(
              testEnv: true,
              currencyCode: "USD",
              merchantCountryCode: "US",
            ),
            merchantDisplayName: 'shakil',
          ),
        );

        displayPaymentSheet();
      }
    } catch (e) {
      debugPrint("Payment Error: $e");
      Get.snackbar(
        "Error",
        "Payment failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
      );
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Get.snackbar(
        "Success",
        "Payment Successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      paymentIntent.value = null;
    } catch (e) {
      debugPrint("Payment Error: $e");
      Get.snackbar(
        "Cancelled",
        "Payment Cancelled",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
      );
    }
  }
}

// ===========================================================================================================
class PaymentService {
  final String _baseUrl =
      "https://your-backend-url.com"; // Replace with actual backend URL

  Future<String?> createPaymentMethod({
    required String cardNumber,
    required String expDate,
    required String cvc,
  }) async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email:
                  "mailto:user@example.com", // You can pass user's email here
            ),
          ),
        ),
      );

      return paymentMethod.id;
    } catch (error) {
      debugPrint("Error creating payment method: $error");
      return null;
    }
  }

  Future<Map<String, dynamic>?> makePayment({
    required String userToken,
    required String planId,
    required String cardHolderName,
    required String cardNumber,
    required String expDate,
    required String cvc,
    required String duration,
  }) async {
    // Step 1: Create Payment Method in Stripe
    final paymentMethodId = await createPaymentMethod(
      cardNumber: cardNumber,
      expDate: expDate,
      cvc: cvc,
    );

    if (paymentMethodId == null) {
      debugPrint("Failed to create payment method");
      return null;
    }

    final url = Uri.parse("$_baseUrl/payment/$planId"); // Backend endpoint

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
        },
        body: jsonEncode({
          "cardHolderName": cardHolderName,
          "duration": duration,
          "paymentMethodId": paymentMethodId, // Send the PaymentMethod ID
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        debugPrint("Payment failed: ${response.body}");
        return null;
      }
    } catch (error) {
      debugPrint("Error processing payment: $error");
      return null;
    }
  }
}
