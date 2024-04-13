import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';
import 'package:powermeter_app/model/measurement.dart';

class MeasurementController extends LifecyleChangeNotifier {
  MeasurementController({required this.host});
  final String host;
  static const uri = '/api/v0.0.0/measurements';
  Timer? _timer;
  List<Measurement>? measurements;
  Measurement? get primaryMeasurement => measurements?.first;

  @override
  void addFirstListener(VoidCallback listener) {
    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) => _fetchMeasurements());
  }

  @override
  void removeLastListener(VoidCallback listener) {
    _timer?.cancel();
  }

  void _fetchMeasurements() async {
    try {
      final response = await http.get(Uri.http(host, uri)).timeout(Duration(milliseconds: 1500));
      measurements = listFromJson(api.processResponse(response), Measurement.fromJson);
    }
    catch (exception) {
      measurements = null;
    }
    notifyListeners();
  }
}