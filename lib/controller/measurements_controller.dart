import 'dart:async';

import 'package:flutter/material.dart';
import 'package:powermeter_app/fetcher/measurements_fetcher.dart';
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';
import 'package:powermeter_app/model/measurement.dart';

class MeasurementsController extends LifecyleChangeNotifier {
  List<Measurement>? measurements;
  Measurement? get primaryMeasurement => measurements?.first;
  Timer? _timer;
  final MeasurementsFetcher fetcher;

  MeasurementsController({required this.fetcher});

  @override
  void addFirstListener(VoidCallback listener) {
    fetch();
    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) => fetch());
  }

  @override
  void removeLastListener(VoidCallback listener) {
    _timer?.cancel();
  }

  void fetch() async {
    try {
      measurements = await fetcher.getMeasurements().timeout(Duration(milliseconds: 1500));
    }
    catch (exception) {
      measurements = null;
    }
    notifyListeners();
  }
}