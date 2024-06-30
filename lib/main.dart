import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/device_controller.dart';
import 'package:powermeter_app/view/pages/device/dashboard_page.dart';
import 'package:powermeter_app/view/pages/device/device_info_page.dart';
import 'package:powermeter_app/view/pages/device/device_settings_page.dart';
import 'package:powermeter_app/view/pages/device/trackers_page.dart';
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
final _overviewNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'overview');
final _deviceNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'overview');

final _router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/device/dashboard',
  routes: [
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   name: page_names.addDevice,
    //   path: '/add-device',
    //   pageBuilder: (context, state) => NoTransitionPage(
    //     child: AddDevicePage(deviceIndex: state.extra as int?)
    //   ),
    // ),
    // ShellRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   navigatorKey: _overviewNavigatorKey,
    //   builder: (context, state, child) => Navigation(
    //     child: child,
    //     destinations: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.list),
    //         label: page_names.devices
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings_rounded),
    //         label: page_names.appSettings
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.info_rounded),
    //         label: page_names.appInfo
    //       ),
    //     ],
    //   ),
    //   routes: [
    //     GoRoute(
    //       name: page_names.devices,
    //       path: '/overview/devices',
    //       parentNavigatorKey: _overviewNavigatorKey,
    //       pageBuilder: (context, state) => NoTransitionPage(child: DevicesPage()),
    //     ),
    //     GoRoute(
    //       name: page_names.appSettings,
    //       path: '/overview/app-settings',
    //       parentNavigatorKey: _overviewNavigatorKey,
    //       pageBuilder: (context, state) => NoTransitionPage(child: AppSettingsPage()),
    //     ),
    //     GoRoute(
    //       name: page_names.appInfo,
    //       path: '/overview/app-info',
    //       parentNavigatorKey: _overviewNavigatorKey,
    //       pageBuilder: (context, state) => NoTransitionPage(child: AppInfoPage()),
    //     ),
    //   ]
    // ),
    ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _deviceNavigatorKey,
      builder: (context, state, child) => Navigation(
        child: child,
        destinations: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.power),
            label: page_names.dashboard
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: page_names.deviceSettings
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: page_names.deviceSettings
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: page_names.deviceInfo
          ),
        ],
      ),
      routes: [
        GoRoute(
          name: page_names.dashboard,
          path: '/device/dashboard',
          parentNavigatorKey: _deviceNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(
            child: DashboardPage(),
          ),
        ),
        GoRoute(
          name: page_names.trackers,
          path: '/device/trackers',
          parentNavigatorKey: _deviceNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(child: TrackersPage()),
        ),
        GoRoute(
          name: page_names.deviceSettings,
          path: '/device/settings',
          parentNavigatorKey: _deviceNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(child: DeviceSettingsPage()),
        ),
        GoRoute(
          name: page_names.deviceInfo,
          path: '/device/info',
          parentNavigatorKey: _deviceNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(child: DeviceInfoPage()),
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