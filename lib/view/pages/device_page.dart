import 'package:flutter/material.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/pages/device/dashboard_page.dart';
import 'package:powermeter_app/view/pages/device/device_info_page.dart';
import 'package:powermeter_app/view/pages/device/device_settings_page.dart';
import 'package:powermeter_app/view/pages/device/trackers_page.dart';
import 'package:powermeter_app/view/widgets/error_builder.dart';

class DevicePage extends StatelessWidget {
  final Device device;

  const DevicePage({
    required this.device,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedIndexController = ValueNotifier<int>(0);

    return ErrorBuilder(
      child: ListenableBuilder(
        listenable: selectedIndexController,
        builder: (context, child) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (value) => selectedIndexController.value = value,
              selectedIndex: selectedIndexController.value,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.power),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.query_stats),
                  label: 'Trackers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Device Settings',
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_rounded),
                  label: 'Device Info',
                ),
              ],
            ),
            body: [
              TrackersPage(),
              DashboardPage(device: device),
              DeviceSettingsPage(),
              DeviceInfoPage(),
            ][selectedIndexController.value],
          );
        }
      ),
    );
  }
}