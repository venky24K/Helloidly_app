import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:helloidly/main.dart'; // Depending on the pubspec name it's Helloidly

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our welcome text is present.
    expect(find.text('Welcome to Hello Idly!'), findsOneWidget);
    
    // Verify the icon is present
    expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
  });
}
