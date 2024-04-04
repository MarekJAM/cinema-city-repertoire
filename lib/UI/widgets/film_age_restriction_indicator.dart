import 'package:flutter/material.dart';

class FilmAgeRestrictionIndicator extends StatelessWidget {
  const FilmAgeRestrictionIndicator(
    this.restriction, {
    super.key,
  });

  final int restriction;

  Color _backgroundColor(int value) {
    if (value >= 18) {
      return Colors.red;
    } else if (value >= 12) {
      return Colors.yellow[700]!;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _backgroundColor(restriction),
      ),
      child: Center(
        child: Text(
          '$restriction+',
          style: const TextStyle(fontSize: 10, color: Colors.black),
        ),
      ),
    );
  }
}