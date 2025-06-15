import 'package:flutter/material.dart';

import 'page_transition_builder.dart';

const _buttonBorderRadius = 10.0;

final _buttonsBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(_buttonBorderRadius),
);

ButtonStyle get _commonButtonStyle => ButtonStyle(
      shape: WidgetStateProperty.all(_buttonsBorder),
    );

final _colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.orange,
  primary: Colors.orange,
  brightness: Brightness.dark,
  surface: Colors.black,
);

final theme = ThemeData(
  colorScheme: _colorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: _buttonsBorder,
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(style: _commonButtonStyle),
  textButtonTheme: TextButtonThemeData(style: _commonButtonStyle),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: Colors.orange,
  ),
);
