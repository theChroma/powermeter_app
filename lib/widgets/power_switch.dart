import 'dart:async';
import 'dart:convert';
import 'package:dispose/dispose.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:powermeter_app/modules/lifecycle_change_notifier.dart';



class PowerSwitchController extends LifecyleChangeNotifier {
  static const uri = '/api/v0.0.0/switch';
  final String host;
  bool? state;
  late Timer _timer;

  PowerSwitchController({
    required this.host,
    this.state
  });

  @override
  void addFirstListener(VoidCallback listener) {
    _fetchState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _fetchState());
    debugPrint('$this someone cares');
  }

  @override
  void removeLastListener(VoidCallback listener) {
    _timer.cancel();
    debugPrint('$this no one cares');
  }

  void _updateState(Future<http.Response> responseFuture) async {
    try {
      final response = await responseFuture.timeout(Duration(seconds: 2));
      if (response.statusCode == 200) {
        state = jsonDecode(response.body);
      }
    } catch(error) {
      state = null;
    }
    notifyListeners();
  }

  void _fetchState() {
    debugPrint('fetching state');
    _updateState(http.get(Uri.http(host, uri)));
  }

  void toggle() {
    if (state == null) return;
    _updateState(http.patch(Uri.http(host, uri), body: jsonEncode(!state!)));
  }
}

class PowerSwitch extends StatelessWidget {
  final PowerSwitchController model;
  PowerSwitch({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (context, child) {
        // debugPrint('PowerSwitch: rerenderd');
        return Switch(
          value: model.state ?? false,
          onChanged: model.state == null ? null : (_) => model.toggle(),
        );
      }
    );
  }
}