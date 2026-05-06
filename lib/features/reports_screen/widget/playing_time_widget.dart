import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

Column playingtime() {
  return Column(
    children: [
      Center(
        child: SizedBox(
          height: 21,
          child: Text(
            "Playing Time Report - John Doe",
            style: globalTextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w600,
              color: Color(0xff333333)
              ),
          ),
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: 355,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 1100,
            barTouchData: BarTouchData(enabled: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: 200,
              verticalInterval: 0.1, //0.167
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Color(0xffABABAB),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Color(0xffABABAB),
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
                  reservedSize: 152,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    String title;
                    switch (value.toInt()) {
                      case 0:
                        title = 'Total Minutes Played  ';
                        break;
                      case 1:
                        title = 'Starting XI                   ';
                        break;
                      case 2:
                        title = 'Bench Appearances   ';
                        break;
                      case 3:
                        title = "Substitutions               ";
                        break;
                      case 4:
                        title = "injury/rest days           ";
                        break;
                      default:
                        title = '';
                    }

                    return Transform.rotate(
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
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 30,
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    if (value == 200 ||
                        value == 400 ||
                        value == 600 ||
                        value == 800 ||
                        value == 1000) {
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
                    toY: 950,
                    color: Color(0xff00BA0B),
                    width: 20,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 160,
                    color: Color(0xff00BA0B),
                    width: 20,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 390,
                    color: Color(0xff00BA0B),
                    width: 20,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 160,
                    color: Color(0xff00BA0B),
                    width: 20,
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    toY: 480,
                    color: Color(0xff00BA0B),
                    width: 20,
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
