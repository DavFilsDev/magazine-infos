import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_infos/main.dart';

void main() {
  testWidgets('App starts and shows RedacteurInterface', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MonApplication());
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
