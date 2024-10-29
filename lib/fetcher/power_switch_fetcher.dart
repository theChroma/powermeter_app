import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;

class PowerSwitchFetcher {
  static const uri = '/api/v0.0.0/switch';
  final String host;

  PowerSwitchFetcher({required this.host});

  Future<bool> getState() async {
    final response = await http.get(Uri.http(host, uri));
    return api.processResponse(response);
  }

  Future<bool> updateState(bool newState) async {
    final response = await http.patch(Uri.http(host, uri), body: jsonEncode(newState));
    return api.processResponse(response);
  }
}