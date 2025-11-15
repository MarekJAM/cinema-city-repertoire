import 'package:flutter/material.dart';

class ErrorColumn extends StatelessWidget {
  final String errorMessage;
  final String? buttonMessage;
  final Function? buttonOnPressed;
  final List<Widget>? buttons;

  const ErrorColumn({
    super.key,
    required this.errorMessage,
    this.buttonMessage,
    this.buttonOnPressed,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            errorMessage,
            textAlign: .center,
            style: const TextStyle(fontSize: 18),
          ),
          const Padding(
            padding: .only(top: 10),
          ),
          if (buttons != null)
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [...buttons!],
            ),
          if (buttonOnPressed != null)
            ElevatedButton(
              onPressed: () {
                buttonOnPressed!();
              },
              child: Text(
                buttonMessage!,
              ),
            ),
        ],
      ),
    );
  }
}
