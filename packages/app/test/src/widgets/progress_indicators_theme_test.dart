import 'package:bitblik/src/theme/app_theme.dart';
import 'package:bitblik/src/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('circular countdown uses dark theme surfaces and text', (
    tester,
  ) async {
    final theme = AppTheme.dark;

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: CircularCountdownTimer(
            startTime: DateTime.now(),
            maxDuration: const Duration(minutes: 1),
          ),
        ),
      ),
    );

    final indicator = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );
    final innerCircle = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(CircularCountdownTimer),
            matching: find.byType(Container),
          )
          .first,
    );
    final decoration = innerCircle.decoration! as BoxDecoration;
    final countdownText = tester.widget<Text>(
      find
          .descendant(
            of: find.byType(CircularCountdownTimer),
            matching: find.byType(Text),
          )
          .first,
    );

    expect(
      (indicator.valueColor! as AlwaysStoppedAnimation<Color>).value,
      theme.colorScheme.surfaceContainerHighest,
    );
    expect(decoration.color, theme.colorScheme.surfaceContainerLow);
    expect(countdownText.style?.color, theme.colorScheme.onSurface);
  });
}
