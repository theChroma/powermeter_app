import 'dart:async';

import 'package:flutter/material.dart';
import 'package:powermeter_app/fetcher/power_switch_fetcher.dart';
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';

class PowerSwitchController extends LifecyleChangeNotifier {
  final PowerSwitchFetcher fetcher;
  bool? state;
  Timer? _timer;

  PowerSwitchController({
    required this.fetcher,
    this.state,
  });

  @override
  void addFirstListener(VoidCallback listener) {
    startPolling();
  }

  @override
  void removeLastListener(VoidCallback listener) {
    stopPolling();
  }

  void startPolling() {
    fetch();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => fetch());
  }

  void stopPolling() => _timer?.cancel();

  void toggle() {
    if (state == null) return;
    _updateState(fetcher.update(!state!));
  }

  void fetch() {
    _updateState(fetcher.get());
  }

  void _updateState(Future<bool> newState) async {
    try {
      state = await newState.timeout(Duration(seconds: 2));
    } catch(exception) {
      state = null;
    }
    notifyListeners();
  }
}