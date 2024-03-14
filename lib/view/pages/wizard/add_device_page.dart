import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/view/pages/page_names.dart' as page_names;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddDevicePage extends StatelessWidget {
  AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
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
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
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
        onPressed: () {
          _formKey.currentState?.saveAndValidate();
          debugPrint(_formKey.currentState?.value.toString());
        },
      ),
    );
  }
}
