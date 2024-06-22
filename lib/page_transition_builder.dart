import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _CustomPageTransitionBuilder(
      routeAnimation: animation,
      child: child,
    );
  }
}

class _CustomPageTransitionBuilder extends StatelessWidget {
  _CustomPageTransitionBuilder({
    required this.routeAnimation,
    required this.child,
  });

  final Animation<double> routeAnimation;

  final Widget child;

  static const begin = Offset(1.0, 0.0);
  static const end = Offset.zero;
  static const curve = Curves.ease;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: routeAnimation.drive(tween),
      child: child,
    );
  }
}
