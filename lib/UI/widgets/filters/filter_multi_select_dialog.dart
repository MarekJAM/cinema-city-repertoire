import 'package:flutter/material.dart';

import 'filter_widgets.dart';

class FilterMultiSelectDialog extends StatelessWidget {
  const FilterMultiSelectDialog({
    @required this.title,
    @required this.values,
    @required this.pickedValues,
  });

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FilterDialogColumn(
                title: title,
                values: values,
                pickedValues: pickedValues,
              ),
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}