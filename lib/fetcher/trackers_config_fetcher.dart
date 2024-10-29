import 'dart:convert';
import 'package:powermeter_app/fetcher/config_fetcher.dart';
import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/model/tracker_config.dart';
import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;

class TrackersConfigFetcher extends ConfigFetcher<Map<String, TrackerConfig>> {
  TrackersConfigFetcher({
    required super.host,
  }) : super(
    uri: '/api/v0.0.0/trackers/config',
    fromJson: (itemsJson) => mapFromJson(itemsJson, TrackerConfig.fromJson),
    toJson: (items) => mapToJson(items, (item) => item.toJson()),
  );

  Future<Map<String, TrackerConfig>> addConfig(TrackerConfig newConfig) async {
    final response = await http.post(Uri.http(host, uri), body: jsonEncode(newConfig.toJson()));
    return fromJson(api.processResponse(response));
  }
}