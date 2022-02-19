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
  var _genres = genreMap.values.toList();
  var _eventTypes = eventTypes;

  var _pickedGenres = genreMap.values.toList();
  var _pickedEventTypes = eventTypes.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              shrinkWrap: true,
              children: [
                FilterMultiSelectDialog(
                  title: "Gatunek",
                  values: _genres,
                  pickedValues: _pickedGenres,
                ),
                FilterMultiSelectDialog(
                  title: "Rodzaj seansu",
                  values: _eventTypes,
                  pickedValues: _pickedEventTypes,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Powrót'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(_pickedGenres);
                      },
                      child: Text('Zatwierdź'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterMultiSelectDialog extends StatelessWidget {
  const FilterMultiSelectDialog(
      {@required this.title,
      @required this.values,
      @required this.pickedValues});

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: MultiSelectDialogField(
        title: Text(title),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.orange[700], width: 1.8),
          ),
        ),
        buttonText: Text(title),
        cancelText: Text('Anuluj'),
        buttonIcon: Icon(Icons.arrow_downward_rounded),
        selectedColor: Colors.orange,
        selectedItemsTextStyle: TextStyle(color: Colors.black),
        items: values.map((e) => MultiSelectItem(e, e)).toList(),
        listType: MultiSelectListType.CHIP,
        initialValue: pickedValues,
        autovalidateMode: AutovalidateMode.always,
        onConfirm: (items) {
          pickedValues.clear();
          print(items);
          items.forEach((el) {
            pickedValues.add(el);
          });
        },
        chipDisplay: MultiSelectChipDisplay.none(),
      ),
    );
  }
}
