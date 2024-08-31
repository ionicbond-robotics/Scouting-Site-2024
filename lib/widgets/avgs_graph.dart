// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';

class AvgsGraph extends StatelessWidget {
  final List<FlSpot> avgSpots;
  final List<FlSpot> teamSpots;

  const AvgsGraph({super.key, required this.avgSpots, required this.teamSpots});

  @override
  Widget build(BuildContext context) {
    final Set<double> xValues = teamSpots.map((spot) => spot.x).toSet();
    final Set<double> yValues = {
      ...avgSpots.map((spot) => spot.y),
      ...teamSpots.map((spot) => spot.y),
    };

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (xValues.contains(value)) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(value.toInt().toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 80,
              getTitlesWidget: (value, meta) {
                if (yValues.contains(value)) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(value.toInt().toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: avgSpots,
            isStrokeCapRound: true,
            isCurved: false,
            dotData: const FlDotData(show: false), // No dots for avgSpots
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: teamSpots,
            isCurved: false,
            dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6, // Customize size of dots for teamSpots
                    color: Colors.red,
                    strokeWidth: 1,
                    strokeColor: Colors.black,
                  );
                }),
            color: Colors.red,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
