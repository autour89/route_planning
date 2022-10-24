import 'package:route_planning/core/models/route.dart';
import 'package:route_planning/core/services/api_client.dart';

abstract class IRouteService {
  Route get route;
  Future searchRoute(String from, String to);
  clear();
}

class RouteService implements IRouteService {
  final ApiClient httpClient;
  late Route _route;

  RouteService({required this.httpClient});

  @override
  Route get route => _route;

  @override
  Future searchRoute(String from, String to) async {
    _route = await httpClient.getRoute(from, to);

    if (_route.steps?.isNotEmpty ?? false) {
      for (var step in _route.steps ?? []) {
        step.location.weather = await httpClient.getWeather(
            step.location.latitude, step.location.longitude);
      }
    }
  }

  @override
  clear() {
    _route = Route(distance: 0, duration: 0, steps: null);
  }
}
