import 'package:flutter/material.dart';

class ErrorColumn extends StatelessWidget {
  final String errorMessage;
  final String? buttonMessage;
  final Function? buttonOnPressed;
  final List<Widget>? buttons;
  final IconData? icon;

  const ErrorColumn({
    super.key,
    required this.errorMessage,
    this.buttonMessage,
    this.buttonOnPressed,
    this.buttons,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 44),
                const SizedBox(height: 12),
              ],
              Text(
                errorMessage,
                textAlign: .center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              if (buttons != null)
                Wrap(
                  alignment: .center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [...buttons!],
                ),
              if (buttonOnPressed != null)
                ElevatedButton(
                  onPressed: () {
                    buttonOnPressed!();
                  },
                  child: Text(buttonMessage!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
