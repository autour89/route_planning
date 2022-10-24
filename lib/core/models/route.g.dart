// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
      distance: json['distance'] as int,
      duration: json['duration'] as int,
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => RouteStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'duration': instance.duration,
      'distance': instance.distance,
      'steps': instance.steps,
    };
