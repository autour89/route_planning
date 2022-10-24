import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:route_planning/core/bloc/route_bloc.dart';
import 'package:route_planning/core/services/route_service.dart';
import 'package:route_planning/views/details_page.dart';
import 'package:route_planning/views/resources.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _fromTextcontroller = TextEditingController();
  final TextEditingController _toTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RouteBloc(routeService: GetIt.I.get<IRouteService>()),
      child: BlocConsumer<RouteBloc, RouteState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case RouteReady:
              Navigator.of(context).push(CupertinoPageRoute(
                  fullscreenDialog: true, builder: (_) => const DetailsPage()));
              break;
            case NoConnection:
              _showCloseDialog(Resources.noConnetionTitle);
              break;
            case FailureState:
              _showCloseDialog(Resources.errorTitle);
              break;
            case EmptyRoute:
              _showCloseDialog(Resources.emptyTitle);
              break;
            default:
              _fromTextcontroller.clear();
              _toTextcontroller.clear();
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text(Resources.planRoutetitle)),
            backgroundColor: Theme.of(context).backgroundColor,
            body: _body(),
          );
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<RouteBloc, RouteState>(builder: ((context, state) {
      switch (state.runtimeType) {
        case BusyState:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSearchField(context, _fromTextcontroller,
                                Resources.fromHintTitle),
                            _buildSearchField(context, _toTextcontroller,
                                Resources.toHintTitle),
                            _buildSearchButton(context)
                          ],
                        ),
                      ),
                    ]),
              ));
      }
    }));
  }

  Widget _buildSearchField(
      BuildContext context, TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      constraints: const BoxConstraints(maxWidth: 700),
      child: TextField(
        controller: controller,
        onChanged: (value) => setState(() {}),
        onSubmitted: (value) {
          _searchRoute(context);
        },
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: hint,
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      controller.clear();
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    icon: const Icon(Icons.clear),
                  ),
            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        textInputAction: TextInputAction.search,
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      constraints: const BoxConstraints(maxWidth: 700),
      child: InkWell(
        onTap: () => _searchRoute(context),
        highlightColor: Colors.transparent,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              margin: const EdgeInsets.all(5),
              child: IconButton(
                onPressed: () => _searchRoute(context),
                icon: const Icon(Icons.search),
              ),
            ),
            const Text(Resources.searchTitle)
          ],
        ),
      ),
    );
  }

  _searchRoute(BuildContext context) {
    if (_fromTextcontroller.text.isNotEmpty &&
        _toTextcontroller.text.isNotEmpty &&
        _fromTextcontroller.text != _toTextcontroller.text) {
      BlocProvider.of<RouteBloc>(context).add(SearchRoute(
          from: _fromTextcontroller.text, to: _toTextcontroller.text));
    }
  }

  _showCloseDialog(String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(Resources.alertTitle,
                style: Theme.of(context).primaryTextTheme.titleLarge),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Resources.closeTitle,
                      style: Theme.of(context).primaryTextTheme.titleMedium))
            ],
          );
        });
  }
}
