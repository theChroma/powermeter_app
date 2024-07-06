import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        final primaryMeasurement = measurementController.measurements?.firstOrNull;
        return Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
              bottom: 0,
              child: MeasurementCard(measurement: Measurement(name: 'Active ', value: 123.2, unit: 'W'))),
            Positioned(
              bottom: 100,
              child: MeasurementCard(measurement: Measurement(name: 'Active Power', value: 123.2, unit: 'W'))),
          ],
        );
      },
    );
  }
}