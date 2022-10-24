import 'package:json_annotation/json_annotation.dart';
import 'package:route_planning/core/models/route_step.dart';

part 'route.g.dart';

@JsonSerializable()
class Route {
  final int duration;
  final int distance;
  final List<RouteStep>? steps;

  Route({required this.distance, required this.duration, required this.steps});

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
