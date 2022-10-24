import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/foundation.dart';
import 'package:route_planning/core/models/route.dart';
import 'package:route_planning/core/models/weather.dart';
import 'package:route_planning/core/services/apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Apis.baseUrl, parser: Parser.FlutterCompute)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('${Apis.routeApi}{from}/{to}')
  Future<Route> getRoute(@Path('from') String from, @Path('to') String to);

  @GET('${Apis.weatherApi}{lat}/{lng}')
  Future<Weather> getWeather(@Path('lat') double lat, @Path('lng') double lng);
}

Route deserializeRoute(Map<String, dynamic> json) => Route.fromJson(json);

Weather deserializeWeather(Map<String, dynamic> json) => Weather.fromJson(json);
