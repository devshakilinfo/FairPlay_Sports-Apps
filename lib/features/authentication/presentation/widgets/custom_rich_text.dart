import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/style/globaltextstyle.dart' show globalTextStyle;

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              //
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFF4CC9FE)),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                      Icons.check,
                      color: Color(0xFF4CC9FE),
                      size: 16,
                    )
                  
            )),
        
      
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'By signing up you agree to the ',
                  style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFFA7A7A7),
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'Terms of Service ',
                  style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFF368FB4),
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //
                    },
                ),
                TextSpan(
                  text: 'and \n',
                  style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFFA7A7A7),
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: globalTextStyle(
                      fontSize: 12,
                      color: Color(0xFF368FB4),
                      fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
