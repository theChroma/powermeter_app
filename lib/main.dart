import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:powermeter_app/view/pages/overview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(DeviceController(
    preferences: await SharedPreferences.getInstance(),
  ));
  runApp(const PowerMeterApp());
}

class PowerMeterApp extends StatelessWidget {
  const PowerMeterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'PowerMeter',
      darkTheme: darkTheme,
      theme: lightTheme,
      home: OverviewPage(),
    );
  }
}