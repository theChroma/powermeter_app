import 'dart:convert';
import 'package:http/http.dart' as http;

dynamic processResponse(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonDecode(response.body);
  }
  else {
    throw ApiException(
      traces: List<String>.from(jsonDecode(response.body)),
      status: '${response.statusCode} ${response.reasonPhrase}'
    );
  }
}

class ApiException implements Exception {
  ApiException({
    required this.traces,
    required this.status,
  });

  final String status;
  final List<String> traces;

  @override
  String toString() {
    return status + '\n\n' + traces.join('\n');
  }
}