import 'package:json_annotation/json_annotation.dart';
import 'package:powermeter_app/helpers/version_json_converter.dart';
import 'package:powermeter_app/model/tracker_config.dart';
import 'package:version/version.dart';

part 'trackers_config.g.dart';

@JsonSerializable()
class TrackersConfig {
  final Map<String, TrackerConfig> trackers;

  @VersionJsonConverter()
  @JsonKey(includeIfNull: false)
  final Version? version;

  TrackersConfig({
    required this.trackers,
    this.version,
  });

  factory TrackersConfig.fromJson(Map<String, dynamic> json) => _$TrackersConfigFromJson(json);

  Map<String, dynamic> toJson() => _$TrackersConfigToJson(this);
}