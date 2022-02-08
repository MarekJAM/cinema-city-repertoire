import 'package:flutter/material.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../data/models/film.dart';
import '../../data/models/event.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen();

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _genres = genreMap.values.map((val) => MultiSelectItem(val, val)).toList();
  var _eventTypes = eventTypes.map((val) => MultiSelectItem(val, val)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              FilterMultiSelectDialog(title: "Gatunek", values: _genres),
              FilterMultiSelectDialog(title: "Rodzaj seansu", values: _eventTypes),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterMultiSelectDialog extends StatelessWidget {
  const FilterMultiSelectDialog({
    @required this.title,
    @required this.values
  });

  final String title;
  final List<MultiSelectItem<String>> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MultiSelectDialogField(
        title: Text(title),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange[700], width: 1.8),
        ),
        buttonText: Text(title),
        items: values,
        listType: MultiSelectListType.CHIP,
        initialValue: values.map((e) => e.value).toList(),
        autovalidateMode: AutovalidateMode.always,
        onConfirm: (items) {},
        chipDisplay: MultiSelectChipDisplay.none(),
      ),
    );
  }
}
