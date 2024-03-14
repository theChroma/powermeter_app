import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:powermeter_app/helpers/lifecycle_change_notifier.dart';


class PowerSwitchController extends LifecyleChangeNotifier {
  static const uri = '/api/v0.0.0/switch';
  final String host;
  bool? state;
  Timer? _timer;

  PowerSwitchController({
    required this.host,
    this.state
  });

  @override
  void addFirstListener(VoidCallback listener) {
    _fetchState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => _fetchState());
  }

  @override
  void removeLastListener(VoidCallback listener) {
    _timer?.cancel();
  }

  void _updateState(Future<http.Response> responseFuture) async {
    try {
      state = api.processResponse(await responseFuture.timeout(Duration(seconds: 2)));
    } catch(exception) {
      state = null;
    }
    notifyListeners();
  }

  void _fetchState() {
    _updateState(http.get(Uri.http(host, uri)));
  }

  void toggle() {
    if (state == null) return;
    _updateState(http.patch(Uri.http(host, uri), body: jsonEncode(!state!)));
  }
}