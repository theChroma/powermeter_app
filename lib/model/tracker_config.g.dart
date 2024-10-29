// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackerConfig _$TrackerConfigFromJson(Map<String, dynamic> json) =>
    TrackerConfig(
      title: json['title'] as String,
      duration:
          TrackerConfig.durationFromJson((json['duration_s'] as num).toInt()),
      sampleCount: (json['sampleCount'] as num).toInt(),
    );

Map<String, dynamic> _$TrackerConfigToJson(TrackerConfig instance) =>
    <String, dynamic>{
      'title': instance.title,
      'duration_s': TrackerConfig.durationToJson(instance.duration),
      'sampleCount': instance.sampleCount,
    };
