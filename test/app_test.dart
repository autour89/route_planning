import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:route_planning/app.dart';
import 'package:route_planning/views/home_page.dart';

void main() {
  group('CounterApp', () {
    testWidgets('is a MaterialApp', (tester) async {
      expect(App(), isA<MaterialApp>());
    });

    testWidgets('home is HomePage', (tester) async {
      expect(App().home, isA<Home>());
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(Home), findsOneWidget);
    });
  });
}
