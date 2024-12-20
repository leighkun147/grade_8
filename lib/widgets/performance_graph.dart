import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceGraph extends StatelessWidget {
  const PerformanceGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 20,
                    reservedSize: 40,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      if (value >= 0 && value < days.length) {
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 40),
                    const FlSpot(1, 50),
                    const FlSpot(2, 45),
                    const FlSpot(3, 60),
                    const FlSpot(4, 65),
                    const FlSpot(5, 55),
                    const FlSpot(6, 70),
                  ],
                  isCurved: true,
                  color: Theme.of(context).primaryColor,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                ),
              ],
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 100,
            ),
          ),
        ),
      ),
    );
  }
}
