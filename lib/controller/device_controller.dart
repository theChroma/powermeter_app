import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/model/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceController extends ChangeNotifier {
  DeviceController({
    required this.preferences,
    this.storageKey = 'devices',
  });

  final SharedPreferences preferences;
  final String storageKey;

  List<Device> get devices {
    try {
      return listFromJson(jsonDecode(preferences.getString(storageKey)!), Device.fromJson);
    }
    catch (exception) {
      return [];
    }
  }

  Future<void> add(Device newDevice) async {
    await _store([newDevice, ...devices]);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final reorderdDevices = devices;
    reorderdDevices.insert(newIndex, reorderdDevices.removeAt(oldIndex));
    await _store(reorderdDevices);
  }

  Future<void> replace(int index, Device newDevice) async {
    final newDevices = devices;
    newDevices[index] = newDevice;
    await _store(newDevices);
  }

  Future<void> remove(List<int> indices) async {
    final newDevices = devices;
    indices.sort((a, b) => b.compareTo(a));
    for (final index in indices) {
      newDevices.removeAt(index);
    }
    await _store(newDevices);
  }

  Future<void> _store(List<Device> devices) async {
    final didStore = await preferences.setString(
      storageKey,
      jsonEncode(listToJson(devices, (device) => device.toJson()))
    );
    if (didStore) {
      notifyListeners();
    }
  }
}