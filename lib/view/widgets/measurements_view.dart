import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
import 'package:powermeter_app/model/measurement.dart';
import 'package:powermeter_app/view/widgets/measurement_card.dart';

class MeasurementsView extends StatelessWidget {
  final MeasurementsController measurementController;

  const MeasurementsView({
    required this.measurementController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: measurementController,
      builder: (context, child) {
        if (measurementController.measurements == null) {
          return Center(
            child: CircularProgressIndicator()
          );
        }
        else {
          return Row(
            children: [
              Column(
                children: [
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                ],
              ),
              Column(
                children: [
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                  MeasurementCard(measurement: Measurement(name: 'foo', value: 213, unit: 'W')),
                ],
              )
            ],
          );
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2,
            children: [
              for (final measurement in measurementController.measurements!)
                MeasurementCard(measurement: measurement),
            ]
          );
        }
      },
    );
  }
}