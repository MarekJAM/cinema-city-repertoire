import 'package:flutter/material.dart';

class ErrorColumn extends StatelessWidget {
  final String errorMessage;
  final String buttonMessage;
  final Function buttonOnPressed;

  const ErrorColumn({
    Key? key,
    required this.errorMessage,
    required this.buttonMessage,
    required this.buttonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 18),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ElevatedButton(
            onPressed: () {
              buttonOnPressed();
            },
            child: Text(
              buttonMessage,
            ),
          ),
        ],
      ),
    );
  }
}
