import 'package:flutter/material.dart';
import 'package:powermeter_app/view/pages/overview/app_info_page.dart';
import 'package:powermeter_app/view/pages/overview/app_settings_page.dart';
import 'package:powermeter_app/view/pages/overview/devices_page.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

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
                icon: Icon(Icons.list),
                label: 'Devices',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'App Settings',
              ),
              NavigationDestination(
                icon: Icon(Icons.info_rounded),
                label: 'App Info',
              ),
            ],
          ),
          body: [
            DevicesPage(),
            AppSettingsPage(),
            AppInfoPage(),
          ][selectedIndexController.value],
        );
      }
    );
  }
}