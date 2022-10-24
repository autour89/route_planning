import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:route_planning/app.dart';
import 'package:route_planning/app_bloc_observer.dart';
import 'package:route_planning/core/services/api_client.dart';
import 'package:route_planning/core/services/route_service.dart';

void main() {
  GetIt.I.registerSingleton<ApiClient>(ApiClient(Dio()));
  GetIt.I.registerSingleton<IRouteService>(
      RouteService(httpClient: GetIt.I.get<ApiClient>()));
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
