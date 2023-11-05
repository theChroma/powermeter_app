import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/pages/page_names.dart' as page_names;
import 'package:powermeter_app/widgets/add_device_form.dart';

class AddDevicePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page_names.addDevice),
        leading: BackButton(
          onPressed: () {
            context.goNamed(page_names.devices);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: AddDeviceForm(formKey: _formKey),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.goNamed('Devices');
          }
        },
      ),
    );
  }
}
