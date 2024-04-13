import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/view/pages/overview/app_settings_page.dart';
import 'package:powermeter_app/view/pages/overview/app_info_page.dart';
import 'package:powermeter_app/view/pages/overview/devices_page.dart';
import 'package:powermeter_app/view/pages/wizard/add_device_page.dart';
import 'package:powermeter_app/theme.dart';
import 'package:powermeter_app/view/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:powermeter_app/view/pages/page_names.dart' as page_names;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(DeviceController(
    preferences: await SharedPreferences.getInstance(),
  ));
  runApp(const PowerMeterApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/overview/devices',
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: page_names.addDevice,
      path: '/add-device',
      pageBuilder: (context, state) => NoTransitionPage(child: AddDevicePage()),
    ),
    ShellRoute(
      builder: (context, state, child) => Navigation(
        child: child,
        destinations: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: page_names.devices
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: page_names.appSettings
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: page_names.appInfo
          ),
        ],
      ),
      routes: [
        GoRoute(
          name: page_names.devices,
          path: '/overview/devices',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DevicesPage());
          },
        ),
        GoRoute(
          name: page_names.appSettings,
          path: '/overview/app-settings',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: AppSettingsPage());
          },
        ),
        GoRoute(
          name: page_names.appInfo,
          path: '/overview/app-info',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: AppInfoPage());
          },
        ),
      ]
    ),
  ],
);

class PowerMeterApp extends StatelessWidget {
  const PowerMeterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      themeMode: ThemeMode.dark,
      title: 'PowerMeter',
      darkTheme: darkTheme,
      theme: lightTheme,
    );
  }
}