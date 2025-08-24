import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/model/tracker.dart';

class TrackersFetcher {
  static const uri = '/api/v0.0.0/trackers';
  final String host;

  TrackersFetcher({required this.host});

  Future<Map<String, Tracker>> get() async {
    final response = await http.get(Uri.http(host, uri));
    return mapFromJson(api.processResponse(response), Tracker.fromJson);
  }
}
