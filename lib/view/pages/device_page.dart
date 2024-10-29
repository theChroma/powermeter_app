import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/helpers/dependencies.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:powermeter_app/view/pages/device/dashboard_page.dart';
import 'package:powermeter_app/view/pages/device/device_info_page.dart';
import 'package:powermeter_app/view/pages/device/device_settings_page.dart';
import 'package:powermeter_app/view/pages/device/trackers_page.dart';

class DevicePage extends StatefulWidget {
  final Device device;

  const DevicePage({
    required this.device,
    super.key,
  });

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  static const _scopeName = 'device';

  @override
  void initState() {
    super.initState();
    GetIt.instance.pushNewScope(
      scopeName: _scopeName,
      init: (getIt) => registerDeviceDependencies(widget.device),
      isFinal: true,
    );
  }

  @override
  void dispose() {
    GetIt.instance.dropScope(_scopeName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndexController = ValueNotifier<int>(0);

    return ListenableBuilder(
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
            TrackersPage(device: widget.device),
            DashboardPage(device: widget.device),
            DeviceSettingsPage(),
            DeviceInfoPage(),
          ][selectedIndexController.value],
        );
      }
    );
  }
}