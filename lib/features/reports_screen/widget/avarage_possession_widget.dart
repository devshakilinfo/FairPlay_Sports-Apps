import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pc;
import 'package:sports_apps/core/style/globaltextstyle.dart';

Expanded avaragepossession(Map<String, double> dataMap, BuildContext context) {
  return Expanded(
    child: pc.PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 2.0,
      colorList: [Color(0xff5E8BCA), Color(0xff00BA0B)],
      chartType: pc.ChartType.disc,
      ringStrokeWidth: 30,
      legendOptions: pc.LegendOptions(showLegends: false),
      chartValuesOptions: pc.ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        showChartValueBackground: false,
        decimalPlaces: 0,
        chartValueStyle: globalTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
