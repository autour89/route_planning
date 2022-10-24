part of 'route_bloc.dart';

@immutable
abstract class RouteState {}

class InitialState extends RouteState {
  @override
  String toString() => 'Initial state';
}

class BusyState extends RouteState {
  @override
  String toString() => 'Busy state';
}

class RouteReady extends RouteState {
  @override
  String toString() => 'Route ready';
}

class FailureState extends RouteState {
  @override
  String toString() => 'Failure state';
}

class NoConnection extends RouteState {}

class EmptyRoute extends RouteState {}
