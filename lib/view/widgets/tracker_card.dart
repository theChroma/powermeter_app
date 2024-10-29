import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:powermeter_app/model/tracker.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;
  final bool isSelected;

  TrackerCard({
    required this.tracker,
    required this.isSelected,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final chartData = LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: spots ?? const [],
        ),
      ],
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            minIncluded: false,
            maxIncluded: false,
            reservedSize: 35,
          ),
          axisNameWidget: Text('Power in W'),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            minIncluded: true,
            maxIncluded: true,
            reservedSize: 35,
            interval: tracker.sampleCount / 5.0,
            getTitlesWidget: (value, meta) => Text(tracker.getTimeLabel(value.floor())),
          ),
          axisNameWidget: Text('Time'),
        )
      )
    );
    return Center(
      child: SizedBox(
        width: 1000,
        child: Card(
          surfaceTintColor: isSelected ? Colors.purple : null,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    tracker.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: LineChart(chartData),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot>? get spots {
    return tracker.data?.indexed.map(
      (value) => FlSpot(value.$1.toDouble(), value.$2 ?? 0)
    ).toList();
  }
}