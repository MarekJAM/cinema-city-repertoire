import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../widgets/filters/filter_widgets.dart';

var _genres = genreMap.values.toList()..sort();
var _eventTypes = eventTypes;
var _scoreFilter = ScoreFilter(0, true);
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
                      _pickedGenres
                        ..clear()
                        ..addAll(filter.genres);
                    } else if (filter is EventTypeFilter) {
                      _pickedEventTypes
                        ..clear()
                        ..addAll(filter.eventTypes);
                    } else if (filter is ScoreFilter) {
                      _scoreFilter = filter;
                    }
                  },
                );
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  MinimalScoreSlider(scoreFilter: _scoreFilter,),
                  SizedBox(
                    height: 10,
                  ),
                  FilterMultiSelectDialog(
                    title: "Gatunek",
                    values: _genres,
                    pickedValues: _pickedGenres,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FilterMultiSelectDialog(
                    title: "Rodzaj seansu",
                    values: _eventTypes,
                    pickedValues: _pickedEventTypes,
                  ),
                  SizedBox(
                    height: 10,
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
                              ),
                              _scoreFilter,
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
