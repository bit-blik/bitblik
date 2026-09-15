import 'package:bitblik/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light and dark themes expose matching Material color roles', () {
    expect(AppTheme.light.brightness, Brightness.light);
    expect(AppTheme.dark.brightness, Brightness.dark);
    expect(AppTheme.light.useMaterial3, isTrue);
    expect(AppTheme.dark.useMaterial3, isTrue);

    expect(
      AppTheme.light.scaffoldBackgroundColor,
      AppTheme.light.colorScheme.surface,
    );
    expect(
      AppTheme.dark.scaffoldBackgroundColor,
      AppTheme.dark.colorScheme.surface,
    );
    expect(
      AppTheme.dark.colorScheme.surface,
      isNot(AppTheme.light.colorScheme.surface),
    );
  });

  test('dark disabled action buttons use a muted dark surface', () {
    final theme = AppTheme.dark;
    final states = <WidgetState>{WidgetState.disabled};

    for (final style in [
      theme.elevatedButtonTheme.style,
      theme.filledButtonTheme.style,
    ]) {
      expect(
        style?.backgroundColor?.resolve(states),
        theme.colorScheme.surfaceContainerHighest,
      );
      expect(
        style?.foregroundColor?.resolve(states),
        theme.colorScheme.outline,
      );
      expect(style?.elevation?.resolve(states), 0);
    }
  });

  test('all dark button families use muted disabled foregrounds', () {
    final theme = AppTheme.dark;
    final states = <WidgetState>{WidgetState.disabled};

    for (final style in [
      theme.elevatedButtonTheme.style,
      theme.filledButtonTheme.style,
      theme.outlinedButtonTheme.style,
      theme.textButtonTheme.style,
      theme.iconButtonTheme.style,
    ]) {
      expect(
        style?.foregroundColor?.resolve(states),
        theme.colorScheme.outline,
      );
    }
  });

  test('light action buttons retain Material default state colors', () {
    final style = AppTheme.light.elevatedButtonTheme.style;
    final states = <WidgetState>{WidgetState.disabled};

    expect(style?.backgroundColor?.resolve(states), isNull);
    expect(style?.foregroundColor?.resolve(states), isNull);
  });

  test('dark inputs use an elevated surface and explicit state borders', () {
    final theme = AppTheme.dark;
    final input = theme.inputDecorationTheme;

    expect(input.filled, isTrue);
    expect(input.fillColor, theme.colorScheme.surfaceContainerLow);
    expect(
      (input.enabledBorder! as OutlineInputBorder).borderSide.color,
      theme.colorScheme.outlineVariant.withValues(alpha: 0.72),
    );
    expect(
      (input.focusedBorder! as OutlineInputBorder).borderSide.width,
      1.5,
    );
  });
}
