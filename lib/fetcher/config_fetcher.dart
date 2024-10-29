import 'dart:convert';

import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:http/http.dart' as http;

class ConfigFetcher<T> {
  final FromJsonConverter<T> fromJson;
  final ToJsonConverter<T> toJson;
  final String host;
  final String uri;

  ConfigFetcher({
    required this.host,
    required this.uri,
    required this.fromJson,
    required this.toJson
  });

  Future<T> getConfig() async {
    final response = await http.get(Uri.http(host, uri));
    return fromJson(api.processResponse(response));
  }

  Future<T> getDefaultConfig() async {
    final response = await http.get(Uri.http(host, uri + '/default'));
    return fromJson(api.processResponse(response));
  }

  Future<T> updateConfig(T newConfig) async {
    final response = await http.patch(Uri.http(host, uri), body: jsonEncode(toJson(newConfig)));
    return fromJson(api.processResponse(response));
  }

  Future<T> restoreDefaultConfig() async {
    final response = await http.post(Uri.http(host, uri + '/restore-default'));
    return fromJson(api.processResponse(response));
  }
}