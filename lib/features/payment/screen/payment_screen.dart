import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
    final arguments = Get.arguments as Map<String, dynamic>;

    // Extract the arguments
    String planId = arguments['planId'];
    String planName = arguments['planName'];
    String subscriptionType = arguments['subscriptionType'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Plan ID: $planId'),
            Text('Plan Name: $planName'),
            Text('Subscription Type: $subscriptionType'),
            // You can now process payment based on these values
          ],
        ),
      ),
    );
  }
}
