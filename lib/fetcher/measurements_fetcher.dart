import 'package:http/http.dart' as http;
import 'package:powermeter_app/helpers/api.dart' as api;
import 'package:powermeter_app/helpers/json.dart';
import 'package:powermeter_app/model/measurement.dart';

class MeasurementsFetcher {
  static const uri = '/api/v0.0.0/measurements';
  final String host;

  MeasurementsFetcher({required this.host});

  Future<List<Measurement>> get() async {
    final response = await http.get(Uri.http(host, uri));
    return listFromJson(api.processResponse(response), Measurement.fromJson);
  }
}