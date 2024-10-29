import 'package:powermeter_app/helpers/dependencies.dart';
import 'package:powermeter_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:powermeter_app/view/pages/overview_page.dart';
import 'package:powermeter_app/view/widgets/error_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  runApp(const PowerMeterApp());
}

class PowerMeterApp extends StatefulWidget {
  const PowerMeterApp({Key? key}) : super(key: key);

  @override
  State<PowerMeterApp> createState() => _PowerMeterAppState();
}

class _PowerMeterAppState extends State<PowerMeterApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'PowerMeter',
      darkTheme: darkTheme,
      theme: lightTheme,
      home: ErrorBuilder(child: OverviewPage()),
    );
  }
}