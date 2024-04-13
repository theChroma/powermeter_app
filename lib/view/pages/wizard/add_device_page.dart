import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/pages/page_names.dart' as page_names;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddDevicePage extends StatelessWidget {
  AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(page_names.addDevice),
        leading: BackButton(
          onPressed: () {
            context.pop();
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
                    name: 'name',
                    decoration: InputDecoration(label: Text('Display Name')),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'host',
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
            GetIt.I<DeviceController>().add(Device.fromJson(formKey.currentState!.value));
            context.pop();
          }
        },
      ),
    );
  }
}