import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/widgets/device_card.dart';
import 'package:powermeter_app/view/pages/page_names.dart' as page_names;
import 'package:powermeter_app/view/widgets/error_builder.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorBuilder(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_rounded),
          onPressed: () {
            context.pushNamed(page_names.addDevice);
          },
        ),
        body: Center(
          child: Column(
            children: [
              DeviceCard(device: Device(host: '192.168.178.195', name: 'Foo'))
            ]
          ),
        ),
      ),
    );
  }
}