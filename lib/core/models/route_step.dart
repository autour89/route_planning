import 'package:json_annotation/json_annotation.dart';
import 'package:route_planning/core/models/step_location.dart';

part 'route_step.g.dart';

@JsonSerializable()
class RouteStep {
  final String? direction;
  final StepLocation location;

  RouteStep({required this.direction, required this.location});

  factory RouteStep.fromJson(Map<String, dynamic> json) =>
      _$RouteStepFromJson(json);

  Map<String, dynamic> toJson() => _$RouteStepToJson(this);
}
