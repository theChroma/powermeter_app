import 'package:flutter/material.dart';

class AddDeviceForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const AddDeviceForm({required this.formKey, super.key});

  @override
  State<AddDeviceForm> createState() => _AddDeviceFormState();
}

class _AddDeviceFormState extends State<AddDeviceForm> {  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'IP Address',
                ),
                validator: (value) {
                  final ipRegex = RegExp(
                    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
                  );
                  if (ipRegex.hasMatch(value!)) {
                    return null;
                  }
                  return 'Please enter a valid IP Address';
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Device Name',
                ),
                validator: (value) {
              
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}