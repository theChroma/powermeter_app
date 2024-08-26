import 'package:flutter/material.dart';
import 'package:powermeter_app/model/measurement.dart';

class MeasurementCard extends StatelessWidget {
  final Measurement measurement;

  const MeasurementCard({
    required this.measurement,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(measurement.name),
              Text(
                '${measurement.value.toStringAsFixed(measurement.fractionDigits)} ${measurement.unit}',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}