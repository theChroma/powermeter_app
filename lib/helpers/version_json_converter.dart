import 'package:json_annotation/json_annotation.dart';
import 'package:version/version.dart';

class VersionJsonConverter implements JsonConverter<Version, String> {
  const VersionJsonConverter();

  @override
  Version fromJson(String json) => Version.parse(json);

  @override
  String toJson(Version version) => version.toString();
}