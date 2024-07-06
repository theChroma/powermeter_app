import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

@JsonSerializable()
class Measurement {
  final String name;
  final double value;
  final String unit;
  final int fractionDigits;

  Measurement({
    required this.name,
    required this.value,
    required this.unit,
    this.fractionDigits = 0
  });

  factory Measurement.fromJson(Map<String, dynamic> json) => _$MeasurementFromJson(json);
  Map<String, dynamic> toJson() => _$MeasurementToJson(this);
}