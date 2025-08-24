import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:powermeter_app/controller/devices_controller.dart';
import 'package:powermeter_app/controller/measurements_controller.dart';
import 'package:powermeter_app/controller/power_switch_controller.dart';
import 'package:powermeter_app/controller/trackers_controller.dart';
import 'package:powermeter_app/fetcher/devices_fetcher.dart';
import 'package:powermeter_app/fetcher/measurements_fetcher.dart';
import 'package:powermeter_app/fetcher/power_switch_fetcher.dart';
import 'package:powermeter_app/fetcher/trackers_config_fetcher.dart';
import 'package:powermeter_app/fetcher/trackers_fetcher.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerDeviceDependencies(Device device) {
  GetIt.I.registerLazySingleton<MeasurementsController>(
    () => MeasurementsController(
      fetcher: GetIt.I<MeasurementsFetcher>(param1: device.host),
    ),
  );

  GetIt.I.registerLazySingleton<PowerSwitchController>(
    () => PowerSwitchController(
      fetcher: GetIt.I<PowerSwitchFetcher>(param1: device.host),
    ),
  );

  GetIt.I.registerLazySingleton<TrackersController>(
    () => TrackersController(
      fetcher: GetIt.I<TrackersFetcher>(param1: device.host),
      configFetcher: GetIt.I<TrackersConfigFetcher>(param1: device.host),
    ),
  );
}

Future<void> registerDependencies() async {
  // Fetchers
  GetIt.I.registerFactoryParam<MeasurementsFetcher, String, void>(
    (String host, _) => MeasurementsFetcher(host: host)
  );

  GetIt.I.registerFactoryParam<PowerSwitchFetcher, String, void>(
    (String host, _) => PowerSwitchFetcher(host: host)
  );

  GetIt.I.registerFactoryParam<TrackersFetcher, String, void>(
    (String host, _) => TrackersFetcher(host: host)
  );

  GetIt.I.registerFactoryParam<TrackersConfigFetcher, String, void>(
    (String host, _) => TrackersConfigFetcher(host: host)
  );

  GetIt.I.registerSingletonAsync<DevicesFetcher>(
    () async => DevicesFetcher(
      preferences: await SharedPreferences.getInstance(),
    ),
  );

  // Controllers
  GetIt.I.registerFactoryParam<MeasurementsController, String, void>(
    (String host, _) => MeasurementsController(
      fetcher: GetIt.I<MeasurementsFetcher>(param1: host),
    ),
  );

  GetIt.I.registerFactoryParam<PowerSwitchController, String, void>(
    (String host, _) => PowerSwitchController(
      fetcher: GetIt.I<PowerSwitchFetcher>(param1: host),
    ),
  );

  GetIt.I.registerSingletonWithDependencies<DevicesController>(
    () => DevicesController(
      fetcher: GetIt.I<DevicesFetcher>(),
    ),
    dependsOn: [DevicesFetcher],
  );

  GetIt.I.registerSingleton<RouteObserver>(RouteObserver<PageRoute>());

  await GetIt.I.allReady();
}