import 'package:bitblik/src/widgets/bolt12_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the BOLT12 capability as a gradient pill', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Bolt12Badge())),
    );

    expect(find.text('BOLT12'), findsOneWidget);
    expect(find.byIcon(Icons.bolt_rounded), findsOneWidget);

    final decorated = tester.widgetList<Container>(find.byType(Container)).where(
      (container) =>
          container.decoration is BoxDecoration &&
          (container.decoration! as BoxDecoration).gradient != null,
    );
    expect(decorated, isNotEmpty);
  });
}
