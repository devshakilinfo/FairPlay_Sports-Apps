import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_apps/core/custom_widget/authe_custom_text_feild.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/features/payment/payment_controller/payment_Card_controller.dart';

class CardDetails extends StatelessWidget {
  CardDetails({super.key});
  final PaymentCardController paymentCardController = Get.put(
    PaymentCardController(),
  );
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double sizedBoxHeight = (screenHeight < 700) ? :;
    final String planId = "3812ded1-af58-48dc-b317-be2e17451ca2";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Card Details",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff082B09),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 5),
              AuthCustomTextField(
                controller: paymentCardController.nameController,
                text: "Enter Name",
              ),
              SizedBox(height: 20),
              Text(
                "Card Number",
                style: globalTextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              AuthCustomTextField(
                controller: paymentCardController.cardController,
                text: 'Card number',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CVC",
                            style: globalTextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          AuthCustomTextField(
                            controller: paymentCardController.cvcController,
                            text: "CVC",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expires Date",
                            style: globalTextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          AuthCustomTextField(
                            controller:
                                paymentCardController.expiresdateController,
                            text: "MM/YY",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xff00BA0B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () async {
                    paymentCardController.replaceButton();
                    paymentCardController.addNewContainer();
                    paymentCardController.saveAddButtonVisibility(true);
                    Get.back();
                    paymentCardController.makePayment(context);
                  },
                  child: Text(
                    "Save",
                    style: globalTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 34 ? 34 : 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
