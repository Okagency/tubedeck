// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubedeck/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TubeDeckApp());

    // Verify that the app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
