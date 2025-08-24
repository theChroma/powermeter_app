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
      lineBarsData: _segments.map((segment) => LineChartBarData(
          color: segment.isNull
               ? Colors.red
               : Theme.of(context).colorScheme.primary,
          dashArray: segment.isNull ? [2, 2] : null,
          isCurved: true,
          curveSmoothness: 0.2,
          preventCurveOverShooting: true,
          preventCurveOvershootingThreshold: 1,
          spots: segment.value,
        ),
      ).toList(),
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
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: LineChart(chartData),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Divider()
                ),
                FittedBox(
                  child: DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.bodyLarge,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Energy',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Average Power',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${tracker.energy?.toStringAsFixed(2) ?? '-'} kWh'),
                            Text('${tracker.averagePower?.toStringAsFixed(2) ?? '-'} W'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_Nullable<List<FlSpot>>> get _segments {
    if (tracker.data == null) return [];

    final segments = splitIntoSegments(tracker.data!);
    List<_Nullable<List<FlSpot>>> spotSegments = [];
    int i = 0;
    FlSpot? previousSpot;
    for (final segment in segments) {
      List<FlSpot> spotSegment = [if (previousSpot != null) previousSpot];
      for (final value in segment) {
        final spot = FlSpot(i.toDouble(), value ?? 0);
        spotSegment.add(spot);
        previousSpot = spot;
        i++;
      }
      spotSegments.add(_Nullable(value: spotSegment, isNull: segment.first == null));
    }
    return spotSegments;
  }
}

class _Nullable<T> {
  final T value;
  final bool isNull;

  _Nullable({
    required this.value,
    required this.isNull,
  });
}

List<List<double?>> splitIntoSegments(List<double?> values) {
  List<List<double?>> segments = [];
  List<double?> currentSegment = [];
  bool isCurrentSegmentNull = values.first == null;

  for (var value in values) {
    if (value == null) {
      if (!isCurrentSegmentNull) {
        currentSegment = [];
        isCurrentSegmentNull = true;
      }
    } else {
      if (isCurrentSegmentNull) {
        segments.add(currentSegment);
        currentSegment = [];
        isCurrentSegmentNull = false;
      }
    }
    currentSegment.add(value);
  }
  if (currentSegment.isNotEmpty) {
    segments.add(currentSegment);
  }
  return segments;
}
