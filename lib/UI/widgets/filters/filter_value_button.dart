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
    final colorScheme = Theme.of(context).colorScheme;

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isSelected,
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.primary.withValues(alpha: 0.14),
      side: BorderSide(
        color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
      ),
      showCheckmark: false,
      onSelected: (newVal) {
        onValueChanged(newVal, label);
      },
    );
  }
}
