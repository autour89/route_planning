import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:route_planning/core/bloc/cubit/route_details_cubit.dart';
import 'package:route_planning/core/models/route.dart' as r;
import 'package:route_planning/core/models/route_step.dart';
import 'package:route_planning/core/services/route_service.dart';
import 'package:route_planning/views/resources.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RouteDetailsCubit(routeService: GetIt.I.get<IRouteService>()),
      child: BlocBuilder<RouteDetailsCubit, RouteDetailsState>(
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                context.read<RouteDetailsCubit>().clear();
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(Resources.routeDetailstitle),
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                body: _body(context, state),
              ));
        },
      ),
    );
  }

  Widget _body(BuildContext context, RouteDetailsState state) {
    var route = context.read<RouteDetailsCubit>().route;

    var duration = Duration(minutes: route.duration);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${Resources.distanceTitle} : ${route.distance} ${Resources.kmTitle}',
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              '${Resources.durationTitle} : ${duration.inHours} ${Resources.hoursTitle} ${duration.inMinutes - (duration.inHours * 60)} ${Resources.minutesTitle}',
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
          ]),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: route.steps?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var step = route.steps?[index];
            if (step != null) {
              var direction = way(step.direction ?? '');
              var distance = distanceTitle(route, step, index);
              var weather =
                  '${step.location.weather?.description} ${step.location.weather?.temperature} ${Resources.celsiusTitle}';
              return ListTile(
                title: Text('${index + 1}. $direction $distance',
                    style: Theme.of(context).primaryTextTheme.titleMedium),
                subtitle: Text(weather,
                    style: Theme.of(context).primaryTextTheme.titleSmall),
              );
            }
            return Container();
          },
        ))
      ],
    );
  }

  String way(String key) {
    switch (key) {
      case 'turn-right':
        return '->';
      case 'turn-left':
        return '<-';
      default:
        return '<>';
    }
  }

  String distanceTitle(r.Route route, RouteStep step, int index) {
    String distanceTitle = '';

    if (index > 0) {
      var previous = route.steps?[index - 1];

      if (previous != null) {
        var distance = calculateDistance(
            previous.location.latitude,
            previous.location.longitude,
            step.location.latitude,
            step.location.longitude);

        distanceTitle = distance < 1
            ? '${(distance * 1000).toString().split('.')[0]} m.'
            : '${distance.toStringAsFixed(2)} km.';
      }
    }
    return distanceTitle;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
