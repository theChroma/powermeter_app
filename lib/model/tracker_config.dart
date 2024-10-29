import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tracker_config.g.dart';

@JsonSerializable()
class TrackerConfig {
  final String title;
  @JsonKey(
    name: 'duration_s',
    fromJson: durationFromJson,
    toJson: durationToJson,
  )
  final Duration duration;
  final int sampleCount;

  TrackerConfig({
    required this.title,
    required this.duration,
    required this.sampleCount,
  });

  factory TrackerConfig.fromJson(Map<String, dynamic> json) => _$TrackerConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TrackerConfigToJson(this);

  static Duration durationFromJson(int seconds) => Duration(seconds: seconds);
  static int durationToJson(Duration duration) => duration.inSeconds;

  String getTimeLabel(int index) {
    final begin = DateTime.now().subtract(duration);
    final step = duration ~/ sampleCount;
    return _getTimeFormat(step).format(begin.add(step * index));
  }

  static DateFormat _getTimeFormat(Duration step) {
    if (step < Duration(hours: 24)) {
      return DateFormat.Hm();
    }
    if (step < Duration(days: 32)) {
      return DateFormat.MMMd();
    }
    if (step < Duration(days: 300)) {
      return DateFormat.yMMM();
    }
    return DateFormat.y();
  }
}