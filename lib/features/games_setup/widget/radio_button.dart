import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../core/style/globaltextstyle.dart' show globalTextStyle;
import '../controller/games_setup_controller.dart' show GamesSetupController;

class RadioButton extends StatelessWidget {
  const RadioButton({super.key, required this.gamesSetupController});

  final GamesSetupController gamesSetupController;

  @override
  Widget build(BuildContext context) {
   double screenHeight = MediaQuery.of(context).size.height;
   
    double textFontSize = (screenHeight < 700) ? 8 : 12;
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 'Yes',
                    groupValue: gamesSetupController.selectedOption.value,
                    onChanged: (value) {
                      gamesSetupController.setOption(value!);
                    },
                    activeColor: Color(0xFFABABAB),
                  ),
                  Text(
                    'YES',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: 'No',
                    groupValue: gamesSetupController.selectedOption.value,
                    onChanged: (value) {
                      gamesSetupController.setOption(value!);
                    },
                    activeColor: Color(0xFFABABAB),
                  ),
                  Text(
                    'NO',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 'Yes',
                    groupValue: gamesSetupController.selectedOption1.value,
                    onChanged: (value) {
                      gamesSetupController.setOption1(value!);
                    },
                    activeColor: Color(0xFFABABAB),
                  ),
                  Text(
                    'YES',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: 'No',
                    groupValue: gamesSetupController.selectedOption1.value,
                    onChanged: (value1) {
                      gamesSetupController.setOption1(value1!);
                    },
                    activeColor: Color(0xFFABABAB),
                  ),
                  Text(
                    'NO',
                    style: globalTextStyle(
                      color: Color(0xFFABABAB),
                      fontSize: textFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
