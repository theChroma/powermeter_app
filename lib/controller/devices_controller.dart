import 'package:flutter/material.dart';
import 'package:powermeter_app/fetcher/devices_fetcher.dart';
import 'package:powermeter_app/model/device.dart';

class DevicesController extends ChangeNotifier {
  final DevicesFetcher fetcher;

  DevicesController({required this.fetcher});

  List<Device> get devices {
    try {
      return fetcher.read();
    }
    catch (exception) {
      return [];
    }
  }

  Future<void> add(Device newDevice) async {
    await fetcher.write([newDevice, ...devices]);
    notifyListeners();
  }

  Future<void> remove(List<int> indices) async {
    final newDevices = devices;
    indices.sort((a, b) => b.compareTo(a));
    for (final index in indices) {
      newDevices.removeAt(index);
    }
    await fetcher.write(newDevices);
    notifyListeners();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final reorderdDevices = devices;
    reorderdDevices.insert(newIndex, reorderdDevices.removeAt(oldIndex));
    await fetcher.write(reorderdDevices);
    notifyListeners();
  }

  Future<void> replace(int index, Device newDevice) async {
    final newDevices = devices;
    newDevices[index] = newDevice;
    await fetcher.write(newDevices);
    notifyListeners();
  }
}