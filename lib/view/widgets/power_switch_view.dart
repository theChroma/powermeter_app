import 'package:flutter/material.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';


class PowerSwitchView extends StatelessWidget {
  final PowerSwitchController controller;
  PowerSwitchView({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Switch(
          value: controller.state ?? false,
          onChanged: controller.state == null ? null : (_) => controller.toggle(),
        );
      }
    );
  }
}