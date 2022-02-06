import 'package:flutter/material.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../data/models/film.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen();

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _genres = genreMap.values.map((val) => MultiSelectItem(val, val)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Container(
            decoration: BoxDecoration(),
            child: MultiSelectDialogField(
              items: _genres,
              listType: MultiSelectListType.CHIP,
              initialValue: _genres.map((e) => e.value).toList(),
              onConfirm: (list) {

              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    _genres.remove(value);
                  });
                },
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
