import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../widgets/filters/filter_widgets.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const FiltersPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FiltersCubit, FiltersState>(
      listener: (context, state) {
        if (state is FiltersLoaded) {
          context.read<RepertoireBloc>().add(FiltersChanged(state.filters));
        }
      },
      child: const FiltersView(),
    );
  }
}

class FiltersView extends StatefulWidget {
  const FiltersView({Key? key}) : super(key: key);

  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  final _allGenres = genreMap.values.toList()
    ..add(noGenresData)
    ..sort();
  final List<String> _pickedGenres = [];
  final List<String> _pickedEventTypes = [];
  var _scoreFilter = ScoreFilter(0, true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: BlocBuilder<FiltersCubit, FiltersState>(builder: (context, state) {
              if (state is FiltersLoaded) {
                for (var filter in state.filters) {
                  if (filter is GenreFilter) {
                    _pickedGenres
                      ..clear()
                      ..addAll(filter.genres!);
                  } else if (filter is EventTypeFilter) {
                    _pickedEventTypes
                      ..clear()
                      ..addAll(filter.eventTypes!);
                  } else if (filter is ScoreFilter) {
                    _scoreFilter = filter;
                  }
                }
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  MinimalScoreSlider(
                    scoreFilter: _scoreFilter,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilterMultiSelectDialog(
                    title: "Gatunek",
                    values: _allGenres,
                    pickedValues: _pickedGenres,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilterMultiSelectDialog(
                    title: "Rodzaj seansu",
                    values: allEventTypes,
                    pickedValues: _pickedEventTypes,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Powrót'),
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
                        child: const Text('Zastosuj'),
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
