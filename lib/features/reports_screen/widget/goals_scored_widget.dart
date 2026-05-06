import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

SizedBox goalsscored() {
  return SizedBox(
    height: 247,
    child: fl.BarChart(
      fl.BarChartData(
        alignment: fl.BarChartAlignment.spaceAround,
        maxY: 5,
        barTouchData: fl.BarTouchData(enabled: false),
        gridData: fl.FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 0.25,

          getDrawingHorizontalLine: (value) {
            return fl.FlLine(
              color: Colors.grey,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
          getDrawingVerticalLine: (value) {
            return fl.FlLine(
              color: Colors.grey,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: fl.FlTitlesData(
          show: true,
          bottomTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, fl.TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Scored',
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
                        'Canceled',
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
          leftTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, fl.TitleMeta meta) {
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
          rightTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(showTitles: false),
          ),
          topTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(showTitles: false),
          ),
        ),
        borderData: fl.FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: Colors.black, width: 1),
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        barGroups: [
          fl.BarChartGroupData(
            x: 0,
            barRods: [
              fl.BarChartRodData(
                toY: 3,
                color: Colors.green,
                width: 20,
                borderRadius: BorderRadius.zero,
              ),
            ],
          ),

          fl.BarChartGroupData(
            x: 1,
            barRods: [
              fl.BarChartRodData(
                toY: 2,
                color: Colors.red,
                width: 20,
                borderRadius: BorderRadius.zero,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
