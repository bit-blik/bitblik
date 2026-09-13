import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders HTML with a CSS class selector', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Html(
          data: '<p class="help">BOLT12 help</p>',
          style: {'.help': Style(color: Colors.red)},
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.text('BOLT12 help', findRichText: true), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
