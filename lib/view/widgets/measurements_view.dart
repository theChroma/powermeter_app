import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
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
          final measurements = measurementController.measurements!;
          return SizedBox(
            width: 1000,
            child: LayoutGrid(
              columnSizes: [1.fr, 1.fr],
              rowSizes: List.filled(measurements.length, auto),
              rowGap: 10,
              columnGap: 10,
              children: [
                for (final measurement in measurements)
                  MeasurementCard(measurement: measurement),
              ],
            ),
          );
        }
      },
    );
  }
}