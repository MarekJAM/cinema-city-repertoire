import 'package:flutter/material.dart';

import 'filter_widgets.dart';

class FilterDialogColumn extends StatefulWidget {
  const FilterDialogColumn({
    Key key,
    @required this.title,
    @required this.values,
    @required this.pickedValues,
  }) : super(key: key);

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  State<FilterDialogColumn> createState() => _FilterDialogColumnState();
}

class _FilterDialogColumnState extends State<FilterDialogColumn> {
  List<String> tempPickedValues = [];

  @override
  void initState() {
    tempPickedValues.addAll(widget.pickedValues);
    super.initState();
  }

  bool _isInitiallySelected(String val) => tempPickedValues.contains(val);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.cancel,
                ),
              )
            ],
          ),
          Divider(),
          Wrap(
            children: [
              for (int i = 0; i < widget.values.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FilterValueButton(
                    value: widget.values[i],
                    pickedValues: tempPickedValues,
                    isInitiallySelected: _isInitiallySelected(
                      widget.values[i],
                    ),
                  ),
                ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    tempPickedValues.clear();
                    tempPickedValues.addAll(widget.values);
                  });
                },
                child: Text('Reset'),
              ),
              SizedBox(
                width: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  widget.pickedValues.clear();
                  widget.pickedValues.addAll(tempPickedValues);
                  Navigator.of(context).pop();
                },
                child: Text('Zatwierdź'),
              ),
            ],
          )
        ],
      ),
    );
  }
}