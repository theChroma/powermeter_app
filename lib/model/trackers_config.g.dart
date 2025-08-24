// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trackers_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackersConfig _$TrackersConfigFromJson(Map<String, dynamic> json) =>
    TrackersConfig(
      trackers: (json['trackers'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, TrackerConfig.fromJson(e as Map<String, dynamic>)),
      ),
      version: _$JsonConverterFromJson<String, Version>(
          json['version'], const VersionJsonConverter().fromJson),
    );

Map<String, dynamic> _$TrackersConfigToJson(TrackersConfig instance) {
  final val = <String, dynamic>{
    'trackers': instance.trackers,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'version',
      _$JsonConverterToJson<String, Version>(
          instance.version, const VersionJsonConverter().toJson));
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
