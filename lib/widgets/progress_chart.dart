// widgets/progress_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 10,
            verticalInterval: 1,
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Color(0xff68737d),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'MON';
                      break;
                    case 1:
                      text = 'TUE';
                      break;
                    case 2:
                      text = 'WED';
                      break;
                    case 3:
                      text = 'THU';
                      break;
                    case 4:
                      text = 'FRI';
                      break;
                    case 5:
                      text = 'SAT';
                      break;
                    case 6:
                      text = 'SUN';
                      break;
                    default:
                      text = '';
                  }
                  return Text(text, style: style);
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Color(0xff67727d),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  if ([10, 30, 50, 70, 90].contains(value.toInt())) {
                    return Text(value.toInt().toString(), style: style);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 30),
                FlSpot(1, 45),
                FlSpot(2, 40),
                FlSpot(3, 60),
                FlSpot(4, 65),
                FlSpot(5, 70),
                FlSpot(6, 75),
              ],
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
