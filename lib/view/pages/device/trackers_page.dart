import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrackersPage extends StatelessWidget {
  const TrackersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),
        title: Text('Trackers'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(1, 4),
                    FlSpot(4, 4),
                    FlSpot(4, 1),
                    FlSpot(1, 1),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}