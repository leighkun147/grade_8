import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceChart extends StatelessWidget {
  final List<double> scores;
  final List<String> labels;

  const PerformanceChart({
    super.key,
    required this.scores,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= labels.length) return const Text('');
                  return Text(
                    labels[value.toInt()],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: scores.length.toDouble() - 1,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                scores.length,
                (index) => FlSpot(index.toDouble(), scores[index]),
              ),
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
