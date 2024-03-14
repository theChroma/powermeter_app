import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/measurement_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/widgets/power_switch_view.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  const DeviceCard({
    required this.device,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final measurementController = MeasurementController(host: device.host);
    return SizedBox(
      width: 1000,
      child: InkWell(
        onLongPress: () {
          debugPrint('Device Card long pressed');
        },
        onTap: () {
          debugPrint('Device Card tapped');
        },
        child: Card(
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
      ),
    );
  }
}