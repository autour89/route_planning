// import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:route_planning/core/bloc/cubit/route_details_cubit.dart';
import 'package:route_planning/core/bloc/route_bloc.dart';

class MockRouteBloc extends MockBloc<RouteEvent, RouteState>
    implements RouteBloc {}

class MockRouteCubit extends MockCubit<RouteDetailsState>
    implements RouteDetailsCubit {}

void main() {}
