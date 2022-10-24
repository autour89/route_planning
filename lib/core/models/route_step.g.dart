// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteStep _$RouteStepFromJson(Map<String, dynamic> json) => RouteStep(
      direction: json['direction'] as String?,
      location: StepLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RouteStepToJson(RouteStep instance) => <String, dynamic>{
      'direction': instance.direction,
      'location': instance.location,
    };
