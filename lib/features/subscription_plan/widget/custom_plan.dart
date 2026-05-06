import 'package:flutter/material.dart';
import '../../../core/style/globaltextstyle.dart';

// ignore: must_be_immutable
class CustomPlan extends StatelessWidget {
  final String? package;
  final String? price;
  final String? date;
  final bool isselected;
  final VoidCallback? onTap;

  const CustomPlan({
    super.key,
    this.package,
    this.price,
    this.date,
    this.onTap,
    this.isselected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 123,
        width: 76,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFE6F8E7),
          gradient:
              isselected
                  ? LinearGradient(
                    colors: [Color(0xFF00BA0B), Color(0xFF062C08)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                  : null,
          border: Border.all(color: Color(0xFF00BA0B)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              package!,
              style: globalTextStyle(
                color: isselected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        price ?? "",
                        style: globalTextStyle(
                          color:
                              isselected
                                  ? Color(0xFFE6F8E7)
                                  : Color(0xFF00BA0B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        date!,
                        style: globalTextStyle(
                          color:
                              isselected
                                  ? Color(0xFFE6F8E7)
                                  : Color(0xFF00BA0B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
