import 'package:material_ui/material_ui.dart';

extension BuildContextX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
