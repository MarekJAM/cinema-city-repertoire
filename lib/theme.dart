import 'package:flutter/material.dart';

import 'page_transition_builder.dart';

const _buttonBorderRadius = 10.0;
const _cardBorderRadius = 8.0;
const _controlBorderRadius = 8.0;

final _buttonsBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(_buttonBorderRadius),
);

final _cardBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(_cardBorderRadius),
);

ButtonStyle get _commonButtonStyle => ButtonStyle(
  minimumSize: WidgetStateProperty.all(const Size(48, 40)),
  shape: WidgetStateProperty.all(_buttonsBorder),
);

final _colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.orange,
  primary: Colors.orange,
  brightness: Brightness.dark,
  surface: Colors.black,
  surfaceContainerLowest: const Color(0xFF050505),
  surfaceContainerLow: const Color(0xFF111111),
  surfaceContainer: const Color(0xFF181818),
  surfaceContainerHigh: const Color(0xFF202020),
  surfaceContainerHighest: const Color(0xFF2A2A2A),
  outlineVariant: const Color(0xFF4A4A4A),
);

final theme = ThemeData(
  colorScheme: _colorScheme,
  scaffoldBackgroundColor: _colorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: _colorScheme.surface,
    foregroundColor: _colorScheme.onSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    color: _colorScheme.surfaceContainerLow,
    elevation: 0,
    margin: const EdgeInsets.symmetric(vertical: 4),
    shape: _cardBorder,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _colorScheme.surfaceContainerLow,
    modalBackgroundColor: _colorScheme.surfaceContainerLow,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(48, 40),
      shape: _buttonsBorder,
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(style: _commonButtonStyle),
  textButtonTheme: TextButtonThemeData(style: _commonButtonStyle),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: _colorScheme.onSurface,
      disabledForegroundColor: _colorScheme.onSurface.withValues(alpha: 0.38),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: _colorScheme.surfaceContainerHighest,
    selectedColor: _colorScheme.primary.withValues(alpha: 0.14),
    disabledColor: _colorScheme.surfaceContainerHighest.withValues(alpha: 0.38),
    labelStyle: TextStyle(color: _colorScheme.onSurfaceVariant),
    secondaryLabelStyle: TextStyle(color: _colorScheme.primary),
    side: BorderSide(color: _colorScheme.outlineVariant),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_controlBorderRadius),
    ),
    showCheckmark: false,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: _colorScheme.primary,
    inactiveTrackColor: _colorScheme.surfaceContainerHighest,
    thumbColor: _colorScheme.primary,
    overlayColor: _colorScheme.primary.withValues(alpha: 0.16),
    valueIndicatorColor: _colorScheme.primaryContainer,
    valueIndicatorTextStyle: TextStyle(color: _colorScheme.onPrimaryContainer),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return _colorScheme.primary;
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(_colorScheme.onPrimary),
    side: BorderSide(color: _colorScheme.outlineVariant),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _colorScheme.surfaceContainerHighest,
    contentTextStyle: TextStyle(color: _colorScheme.onSurface),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_controlBorderRadius),
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
  tabBarTheme: TabBarThemeData(indicatorColor: Colors.orange),
);
