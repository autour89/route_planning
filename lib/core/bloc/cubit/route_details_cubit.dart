import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:route_planning/core/models/route.dart';
import 'package:route_planning/core/services/route_service.dart';

part 'route_details_state.dart';

class RouteDetailsCubit extends Cubit<RouteDetailsState> {
  final IRouteService routeService;

  RouteDetailsCubit({required this.routeService})
      : super(RouteDetailsInitial());

  Route get route => routeService.route;

  clear() => routeService.clear();
}
