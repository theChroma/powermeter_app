import 'package:flutter/material.dart';

typedef JsonFormFieldTransformer = dynamic Function(String);
typedef Json = Map<String, dynamic>;

class JsonFormValidationException implements Exception {}

class JsonFormField<T> {
  final String jsonKey;
  final TextFormField formField;
  final JsonFormFieldTransformer transformer;

  JsonFormField({
    required this.jsonKey,
    required this.formField,
    this.transformer = transformToString,
  }) {
    assert(formField.controller != null, 'Please pass in a TextEditingController');
  }
}

dynamic transformToString(String string) {
  return string;
}

dynamic transformToNumber(String string) {
  return double.parse(string);
}


class JsonForm extends StatefulWidget {
  final List<JsonFormField> fields;
  final formKey = GlobalKey<FormState>();

  JsonForm({
    required this.fields,
    super.key
  });

  void fill(Json data) {
    for (var field in fields) {
      final value = data[field.jsonKey];
      if (value != null) {
        field.formField.controller!.text = value.toString();
      }
    }
  }

  Json? submit() {
    final isValid = formKey.currentState?.validate() ?? true;
    if (!isValid) {
      return null;
    }
    Map<String, dynamic> data = {};
    for (final field in fields) {
      final text = field.formField.controller!.text;
      data[field.jsonKey] = field.transformer(text);
    }
    return data;
  }

  @override
  State<JsonForm> createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: widget.fields.map((field) {
          return field.formField;
        }).toList(),
      ),
    );
  }
}

