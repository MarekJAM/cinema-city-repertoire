import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastHelper {
  static void show(
    BuildContext context,
    String caption,
    Color color, {
    Duration duration = const Duration(milliseconds: 200),
  }) {
    showToast(
      caption,
      context: context,
      animation: StyledToastAnimation.size,
      reverseAnimation: StyledToastAnimation.size,
      position: StyledToastPosition.center,
      animDuration: duration,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      curve: Curves.easeIn,
      reverseCurve: Curves.linear,
    );
  }
}
