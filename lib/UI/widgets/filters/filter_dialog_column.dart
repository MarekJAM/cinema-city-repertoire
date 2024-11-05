import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import 'filter_widgets.dart';

class FilterDialogColumn extends StatefulWidget {
  const FilterDialogColumn({
    super.key,
    required this.title,
    required this.values,
    required this.pickedValues,
  });

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  State<FilterDialogColumn> createState() => _FilterDialogColumnState();
}

class _FilterDialogColumnState extends State<FilterDialogColumn> {
  bool isSelected(String val) => widget.pickedValues.contains(val);
  
  void onFilterToggled(bool isSelected, String value) {
    setState(() {
      if (isSelected) {
        widget.pickedValues.add(value);
      } else {
        widget.pickedValues.remove(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool allSelected = widget.pickedValues.length == widget.values.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (allSelected) {
                        widget.pickedValues.clear();
                      } else {
                        widget.pickedValues.clear();
                        widget.pickedValues.addAll(widget.values);
                      }
                    });
                  },
                  child: Text(
                    allSelected ? t.filters.unselectAll : t.filters.selectAll,
                  ),
                ),
              ],
            ),
            // const Divider(),
            Wrap(
              children: [
                for (int i = 0; i < widget.values.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FilterValueButton(
                      label: widget.values[i],
                      isSelected: isSelected(
                        widget.values[i],
                      ),
                      onValueChanged: onFilterToggled,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
