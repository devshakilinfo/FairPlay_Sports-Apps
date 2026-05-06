import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

SizedBox matchresult() {
  return SizedBox(
    height: 247,
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 5,
        barTouchData: BarTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 0.167,

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
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Wins',
                        style: globalTextStyle(
                          color: Color(0xff0047AB),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Draws',
                        style: globalTextStyle(
                          color: Color(0xff0047AB),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  case 2:
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Losses',
                        style: globalTextStyle(
                          color: Color(0xff0047AB),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  default:
                    return Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value == 0 || value == 5) {
                  return SizedBox.shrink();
                }
                return Text(
                  value.toInt().toString().padLeft(2, '0'),
                  style: TextStyle(color: Color(0xff0047AB)),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                toY: 3,
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
                toY: 1,
                color: Color(0xff0047AB),
                width: 21,
                borderRadius: BorderRadius.zero,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 2,
                color: Color(0xffFC2E2E),
                width: 21,
                borderRadius: BorderRadius.zero,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
