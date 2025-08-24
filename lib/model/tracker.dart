import 'package:json_annotation/json_annotation.dart';
import 'package:powermeter_app/model/tracker_config.dart';

part 'tracker.g.dart';

@JsonSerializable()
class Tracker extends TrackerConfig {
  final List<double?>? data;

  Tracker({
    required super.title,
    required super.duration,
    required super.sampleCount,
    this.data,
  });

  factory Tracker.fromJson(Map<String, dynamic> json) => _$TrackerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TrackerToJson(this);

  /// Returns the average Power during the duration of the [Tracker] in Watts.
  double? get averagePower {
    if (data == null) {
      return null;
    }
    double sum = 0;
    for (final value in data!) {
      sum += value ?? 0;
    }
    return sum / data!.length;
  }

  /// Returns the amount of energy in kWh measured in during
  /// the duration of the [Tracker]
  double? get energy {
    if (averagePower == null) {
      return null;
    }
    return averagePower! * duration.inHours / 1000;
  }
}