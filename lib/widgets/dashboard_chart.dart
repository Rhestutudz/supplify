import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardChart extends StatelessWidget {
  final List<double> omzetData;

  const DashboardChart({
    super.key,
    required this.omzetData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                omzetData.length,
                (i) => FlSpot(i.toDouble(), omzetData[i]),
              ),
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: false),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
