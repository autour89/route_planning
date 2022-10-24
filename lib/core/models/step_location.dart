import 'package:json_annotation/json_annotation.dart';
import 'package:route_planning/core/models/weather.dart';

part 'step_location.g.dart';

@JsonSerializable()
class StepLocation {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lng')
  final double longitude;

  Weather? weather;

  StepLocation({required this.latitude, required this.longitude});

  factory StepLocation.fromJson(Map<String, dynamic> json) =>
      _$StepLocationFromJson(json);

  Map<String, dynamic> toJson() => _$StepLocationToJson(this);
}
