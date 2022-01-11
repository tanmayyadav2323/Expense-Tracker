import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/graph_learn.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b606),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[400],
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          axisTitleData: FlAxisTitleData(
            bottomTitle: AxisTitle(titleText: 'Months'),
          ),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          titlesData: LineTitles.getTitleData(),
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (val) {
                return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
              }),
          borderData:
              FlBorderData(show: true, border: Border.all(color: Colors.blue)),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6, 5.5),
                FlSpot(8, 2)
              ],
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true,
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
