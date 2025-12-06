import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample_functions_app/main.dart';

void main() {
  testWidgets('renders key sections', (WidgetTester tester) async {
    await tester.pumpWidget(const SampleFunctionsApp());

    expect(find.text('Sample Functions'), findsOneWidget);
    expect(find.text('Counter'), findsOneWidget);

    // Scroll to bring the last card into view (ListView lazily builds children).
    await tester.scrollUntilVisible(
      find.text('Random Number'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Random Number'), findsOneWidget);
  });

  testWidgets('increments the counter', (WidgetTester tester) async {
    await tester.pumpWidget(const SampleFunctionsApp());

    await tester.tap(find.text('+1'));
    await tester.pump();

    expect(find.text('Count: 1'), findsOneWidget);
  });
}
