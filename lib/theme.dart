import 'package:flutter/material.dart';

const _buttonBorderRadius = 10.0;
ButtonStyle get _commonButtonStyle => ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonBorderRadius),
        ),
      ),
    );

final theme = ThemeData(
  primaryColor: Colors.black,
  indicatorColor: Colors.orange,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    accentColor: Colors.orange,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[900],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(style: _commonButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: _commonButtonStyle),
  textButtonTheme: TextButtonThemeData(style: _commonButtonStyle),
);
