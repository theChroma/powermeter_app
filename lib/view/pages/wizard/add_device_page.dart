import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/devices_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddDevicePage extends StatelessWidget {
  final int? deviceIndex;
  AddDevicePage({this.deviceIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final devicesController = GetIt.I<DevicesController>();
    final isEditing = deviceIndex != null;
    final Device? device = isEditing ? devicesController.devices[deviceIndex!] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Device' : 'Add Device'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    autofocus: true,
                    initialValue: device?.name,
                    name: 'name',
                    decoration: InputDecoration(label: Text('Display Name')),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'host',
                    initialValue: device?.host,
                    decoration: InputDecoration(label: Text('Hostname or IP')),
                    validator: FormBuilderValidators.required(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () async {
          if (formKey.currentState == null) return;
          if (formKey.currentState!.saveAndValidate()) {
            final newDevice = Device.fromJson(formKey.currentState!.value);
            if (isEditing) {
              devicesController.replace(deviceIndex!, newDevice);
            }
            else {
              devicesController.add(newDevice);
            }
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
