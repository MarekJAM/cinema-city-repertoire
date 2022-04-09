import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../widgets/filters/filter_widgets.dart';

var _genres = genreMap.values.toList()..sort();
var _eventTypes = eventTypes;
final List<String> _pickedGenres = [];
final List<String> _pickedEventTypes = [];

class FiltersScreen extends StatefulWidget {
  const FiltersScreen();

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void initState() {
    _pickedGenres.addAll(_genres);
    _pickedEventTypes.addAll(_eventTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: BlocBuilder<FiltersCubit, FiltersState>(builder: (context, state) {
              if (state is FiltersLoaded) {
                state.filters.forEach(
                  (filter) {
                    if (filter is GenreFilter) {
                      _pickedGenres.clear();
                      _pickedGenres.addAll(filter.genres);
                    } else if (filter is EventTypeFilter) {
                      _pickedEventTypes.clear();
                      _pickedEventTypes.addAll(filter.eventTypes);
                    }
                  },
                );
              }
              return ListView(
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
                          BlocProvider.of<FiltersCubit>(context).saveFilters(
                            [
                              GenreFilter(
                                [..._pickedGenres],
                              ),
                              EventTypeFilter(
                                [..._pickedEventTypes],
                              )
                            ],
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Zastosuj'),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}