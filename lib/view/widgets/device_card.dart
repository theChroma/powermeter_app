import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/measurement_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/controller/selection_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/widgets/power_switch_view.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    required this.device,
    this.isSelected = false,
    this.isSelectionMode = false,
    super.key,
  });

  final Device device;
  final bool isSelected;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    final measurementController = MeasurementController(host: device.host);

    final child = SizedBox(
      width: 1000,
      child: Card(
        surfaceTintColor: isSelected ? Colors.purple : null,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    device.name,
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  Text(device.host),
                ],
              ),
              ListenableBuilder(
                listenable: measurementController,
                builder: (context, child) {
                  final value = measurementController.measurements?.first.value.clamp(0, double.nan).toStringAsFixed(1) ?? '-';
                  final unit = measurementController.measurements?.first.unit ?? '';
                  return Text('$value $unit', style: TextStyle(fontSize: 25),);
                }
              ),
              PowerSwitchView(controller: PowerSwitchController(host: device.host)),
            ],
          ),
        ),
      ),
    );

    if (isSelectionMode) return child;
    return GestureDetector(
      onTap: () => debugPrint('device card tapped'),
      child: child,
    );
  }
}