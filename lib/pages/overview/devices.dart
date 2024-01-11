import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:powermeter_app/pages/page_names.dart' as page_names;

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          context.pushNamed(page_names.addDevice);
        },
      ),
      body: Column(
        children: [
          
        ]
      ),
    );
  }
}