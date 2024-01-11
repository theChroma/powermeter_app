import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/pages/page_names.dart' as page_names;
import 'package:powermeter_app/widgets/json_form.dart';
import 'package:powermeter_app/modules/validator.dart' as validator;

class AddDevicePage extends StatelessWidget {
  final _form = JsonForm(
    fields: [
      JsonFormField(
        jsonKey: 'address',
        formField: TextFormField(
          controller: TextEditingController(),
          decoration: InputDecoration(
            labelText: 'Hostname or IP Address',
          ),
          validator: validator.validateNonEmpty,
        ),
      ),
      JsonFormField(
        jsonKey: 'name',
        formField: TextFormField(
          controller: TextEditingController(),
          decoration: InputDecoration(
            labelText: 'Display Name',
          ),
          validator: validator.validateNonEmpty,
        ),
      )
    ],
  );

  AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: [
                _form,
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check_rounded),
        onPressed: () {
          print(jsonEncode(_form.submit()));
        },
      ),
    );
  }
}
