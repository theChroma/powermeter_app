import 'dart:convert';
import 'package:powermeter_app/fetcher/config_fetcher.dart';
import 'package:powermeter_app/model/tracker_config.dart';
import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:powermeter_app/model/trackers_config.dart';

class TrackersConfigFetcher extends ConfigFetcher<TrackersConfig> {
  TrackersConfigFetcher({
    required super.host,
  }) : super(
    uri: '/api/v0.0.0/trackers/config',
    fromJson: TrackersConfig.fromJson,
    toJson: (config) => config.toJson(),
  );

  Future<TrackersConfig> add(TrackerConfig newConfig) async {
    final response = await http.post(Uri.http(host, uri), body: jsonEncode(newConfig.toJson()));
    return fromJson(api.processResponse(response));
  }

  Future<TrackersConfig> delete(Set<String> ids) async {
    final response = await http.delete(Uri.http(host, uri), body: jsonEncode(ids.toList()));
    final processedResponse = api.processResponse(response);
    return fromJson(processedResponse);
  }
}