import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

final ValueNotifier<String> selectedPlayerNotifier = ValueNotifier<String>(
  'Aiden',
);

Column playerperformace() {
  return Column(
    children: [
      Center(
        child: SizedBox(
          height: 21,
          child: Text(
            "Player Performance Report",
            style: globalTextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: Color(0xff333333)
              ),
          ),
        ),
      ),
      SizedBox(height: 15),
      SizedBox(
        height: 18,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: selectedPlayerNotifier,
              builder: (context, selectedPlayer, _) {
                return Container(
                  width: 81,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff0047AB)),
                    borderRadius: BorderRadius.circular(2)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showPopup(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          selectedPlayer,
                          style: TextStyle(fontSize: 12, color: Color(0xff0047AB),fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.arrow_drop_down, color: Color(0xff0047AB), size: 18),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: 331,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 110,
            barTouchData: BarTouchData(enabled: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: 20,
              verticalInterval: 0.1, //0.167
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 115,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    String title;
                    switch (value.toInt()) {
                      case 0:
                        title = 'Goals Scored  ';
                        break;
                      case 1:
                        title = 'Assists             ';
                        break;
                      case 2:
                        title = 'Yellow Cards   ';
                        break;
                      case 3:
                        title = "Red Cards        ";
                        break;
                      case 4:
                        title = "Shots on Target";
                        break;
                      default:
                        title = '';
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Transform.rotate(
                        angle: -90 * 3.14159 / 180,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: globalTextStyle(
                              color: Color(0xff0047AB),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    if (value == 20 ||
                        value == 40 ||
                        value == 60 ||
                        value == 80 ||
                        value == 100) {
                      return Text(
                        value.toInt().toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: Color(0xff0047AB),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 81,
                    color: Color(0xff00BA0B),
                    width: 21,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 63,
                    color: Color(0xff00BA0B),
                    width: 21,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 18,
                    color: Color(0xff00BA0B),
                    width: 21,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 16,
                    color: Color(0xff00BA0B),
                    width: 21,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    toY: 96,
                    color: Color(0xff00BA0B),
                    width: 21,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void _showPopup(BuildContext context) {
  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.8,
          height: 322,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 322,
                child: Scrollbar( 
                  thumbVisibility: true, 
                  thickness: 8, 
                  radius: Radius.circular(50), 
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      _popupOption(context, "Aiden", "CF", IconPath.aiden),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "A.erkasen", "LMF", IconPath.aerkasen),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "Finn", "RWF", IconPath.finn),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "Benjamin", "CF", IconPath.benjamin),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "Caleb", "LWF", IconPath.caleb),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "Daniel", "RWF", IconPath.daniel),
                      Divider(height: 0.01, color: Color(0xffD9D9D9)),
                      _popupOption(context, "Elijah", "LMF", IconPath.elijah),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);

}

Widget _popupOption(
  BuildContext context,
  String playerName,
  String position,
  String imagePath,
) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage(imagePath), 
      radius: 20, 
    ),
    title: Text(
      playerName,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xff082B09)),
    ),
    subtitle: Text(position,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff00BA0B)),),
    onTap: () {
      
      Navigator.pop(context);
    },
  );
}
