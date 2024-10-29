import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/pages/device_page.dart';
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
    final measurementController = GetIt.I<MeasurementsController>(param1: device.host);

    final child = SizedBox(
      width: 1000,
      child: Card(
        surfaceTintColor: isSelected ? Colors.purple : null,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(device.host),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: ListenableBuilder(
                  listenable: measurementController,
                  builder: (context, child) {
                    final primaryMeasurement =
                        measurementController.measurements?.firstOrNull;
                    final value = primaryMeasurement?.value.toStringAsFixed(
                            primaryMeasurement.fractionDigits) ??
                        '-';
                    final unit = primaryMeasurement?.unit ?? '';
                    return Text(
                      '$value $unit',
                      style: TextStyle(fontSize: 25),
                    );
                  }
                ),
              ),
              PowerSwitchView(
                  controller: GetIt.I<PowerSwitchController>(param1: device.host)
              ),
            ],
          ),
        ),
      ),
    );

    if (isSelectionMode) return child;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DevicePage(device: device);
        }));
      },
      child: child,
    );
  }
}
