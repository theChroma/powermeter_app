import 'dart:convert';

import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesFetcher {
  static const storageKey = 'devices';
  final SharedPreferences preferences;

  DevicesFetcher({required this.preferences});

  List<Device> read() {
    return listFromJson(jsonDecode(preferences.getString(storageKey)!), Device.fromJson);
  }

  Future<void> write(List<Device> devices) async {
    await preferences.setString(
      storageKey,
      jsonEncode(
        listToJson(devices, (device) => device.toJson())
      ),
    );
  }
}