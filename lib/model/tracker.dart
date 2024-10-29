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

}