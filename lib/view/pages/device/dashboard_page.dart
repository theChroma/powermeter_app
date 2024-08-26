import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/model/device.dart';
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: MeasurementsView(measurementController: MeasurementsController(host: device.host)),
              ),
              SizedBox(
                width: 200,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: PowerSwitchView(
                    controller: PowerSwitchController(host: device.host)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}