import 'package:json_annotation/json_annotation.dart';

part 'tracker.g.dart';

@JsonSerializable()
class Tracker {
  final String title;
  @JsonKey(
    name: 'duration_s',
    fromJson: _durationFromJson,
    toJson: _durationToJson,
  )
  final Duration duration;
  final int sampleCount;
  final List<double>? data;

  Tracker({
    required this.title,
    required this.duration,
    required this.sampleCount,
    required this.data,
  });

  factory Tracker.fromJson(Map<String, dynamic> json) => _$TrackerFromJson(json);
  Map<String, dynamic> toJson() => _$TrackerToJson(this);

  static Duration _durationFromJson(int seconds) => Duration(seconds: seconds);
  static int _durationToJson(Duration duration) => duration.inSeconds;
}