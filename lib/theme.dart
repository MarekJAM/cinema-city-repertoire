import 'package:flutter/material.dart';

import 'page_transition_builder.dart';

const _buttonBorderRadius = 10.0;

final _buttonsBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(_buttonBorderRadius),
);

ButtonStyle get _commonButtonStyle => ButtonStyle(
      shape: MaterialStateProperty.all(_buttonsBorder),
    );

final _colorScheme = ColorScheme.fromSwatch(
  primarySwatch: Colors.orange,
  accentColor: Colors.orange,
  brightness: Brightness.dark,
  backgroundColor: Colors.grey[900],
);

final theme = ThemeData(
  primaryColor: Colors.black,
  indicatorColor: Colors.orange,
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
    }
  ),
);