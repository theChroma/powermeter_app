// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) => Tracker(
      title: json['title'] as String,
      duration: Tracker._durationFromJson(json['duration_s'] as int),
      sampleCount: json['sampleCount'] as int,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'title': instance.title,
      'duration_s': Tracker._durationToJson(instance.duration),
      'sampleCount': instance.sampleCount,
      'data': instance.data,
    };