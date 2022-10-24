import 'package:flutter/material.dart';
import 'package:route_planning/views/app_theme.dart';
import 'package:route_planning/views/home_page.dart';

class App extends MaterialApp {
  App({super.key})
      : super(
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            home: const Home());
}
