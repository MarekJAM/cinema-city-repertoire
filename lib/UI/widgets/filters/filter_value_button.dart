import 'package:flutter/material.dart';

class FilterValueButton extends StatefulWidget {
  const FilterValueButton({
    Key? key,
    required this.value,
    required this.pickedValues,
    required this.isInitiallySelected,
  }) : super(key: key);

  final String value;
  final List<String> pickedValues;
  final bool isInitiallySelected;

  @override
  State<FilterValueButton> createState() => _FilterValueButtonState();
}

class _FilterValueButtonState extends State<FilterValueButton> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        widget.value,
      ),
      selected: widget.pickedValues.contains(widget.value),
      onSelected: (value) {
        setState(() {
          toggleValue();
        });
      },
    );
  }

  void toggleValue() {
    if (widget.pickedValues.contains(widget.value)) {
      widget.pickedValues.remove(widget.value);
    } else {
      widget.pickedValues.add(widget.value);
    }
  }
}
