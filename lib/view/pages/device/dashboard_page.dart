import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/model/measurement.dart';
import 'package:powermeter_app/view/widgets/measurement_card.dart';
import 'package:powermeter_app/view/widgets/measurements_view.dart';
import 'package:powermeter_app/view/widgets/power_switch_view.dart';

class DashboardPage extends StatelessWidget {
  final Device device;

  const DashboardPage({
    required this.device,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),
        title: Text('Dashboard'),
      ),
      body: Center(
        child: MeasurementsView(measurementController: MeasurementsController(host: device.host)),
      ),
      floatingActionButton: Positioned(
        width: 100,
        height: 50,
        child: PowerSwitchView(controller: PowerSwitchController(host: device.host))
      ),
    );
  }
}