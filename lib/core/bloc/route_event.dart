part of 'route_bloc.dart';

@immutable
abstract class RouteEvent {}

class SearchRoute extends RouteEvent {
  final String from;
  final String to;
  SearchRoute({required this.from, required this.to});
}
