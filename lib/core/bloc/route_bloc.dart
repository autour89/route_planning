import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:route_planning/core/services/route_service.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final IRouteService routeService;

  RouteBloc({required this.routeService}) : super(InitialState()) {
    on<SearchRoute>(_onSearchRoute);
  }

  Future _onSearchRoute(SearchRoute event, Emitter<RouteState> emitter) async {
    try {
      emitter(BusyState());

      if (await InternetConnectionChecker().hasConnection) {
        await routeService.searchRoute(event.from, event.to);
      } else {
        emitter(NoConnection());
        return;
      }

      if (routeService.route.steps?.isEmpty ?? true) {
        emitter(EmptyRoute());
      } else {
        emitter(RouteReady());
      }
    } catch (e) {
      emitter(FailureState());
    }
  }
}
