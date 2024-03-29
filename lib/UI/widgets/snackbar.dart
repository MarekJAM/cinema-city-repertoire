import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showSnackbar(String message, [SnackbarType type = SnackbarType.info]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colorScheme.onTertiaryContainer)),
        backgroundColor: type == SnackbarType.error ? colorScheme.error : colorScheme.tertiaryContainer,
      ),
    );
  }
}

enum SnackbarType {
  error,
  info,
}
