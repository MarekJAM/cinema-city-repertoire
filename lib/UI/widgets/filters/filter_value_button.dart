import 'package:flutter/material.dart';

class FilterValueButton extends StatelessWidget {
  const FilterValueButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onValueChanged,
  });

  final String label;
  final bool isSelected;
  final Function(bool, String) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
      ),
      selected: isSelected,
      onSelected: (newVal) {
        onValueChanged(newVal, label);
      },
    );
  }
}
