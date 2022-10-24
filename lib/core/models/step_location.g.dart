// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepLocation _$StepLocationFromJson(Map<String, dynamic> json) => StepLocation(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
    )..weather = json['weather'] == null
        ? null
        : Weather.fromJson(json['weather'] as Map<String, dynamic>);

Map<String, dynamic> _$StepLocationToJson(StepLocation instance) =>
    <String, dynamic>{
      'lat': instance.latitude,
      'lng': instance.longitude,
      'weather': instance.weather,
    };
