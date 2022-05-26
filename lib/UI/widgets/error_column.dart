import 'package:flutter/material.dart';

class ErrorColumn extends StatelessWidget {
  final String errorMessage;
  final String? buttonMessage;
  final Function? buttonOnPressed;
  final List<Widget>? buttons;

  const ErrorColumn({
    Key? key,
    required this.errorMessage,
    this.buttonMessage,
    this.buttonOnPressed,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          if (buttons != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
