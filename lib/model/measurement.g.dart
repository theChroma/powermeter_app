// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'unit': instance.unit,
    };
