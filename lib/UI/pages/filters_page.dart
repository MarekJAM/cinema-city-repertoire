import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../../i18n/strings.g.dart';
import '../widgets/filters/filter_widgets.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

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
  const FiltersView({super.key});

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
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        title: Text(t.filters.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
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
              child: Text(t.apply),
            ),
          ),
        ],
      ),
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
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
                FilterDialogColumn(
                  title: t.filters.typeOfShow,
                  values: allEventTypes,
                  pickedValues: _pickedEventTypes,
                ),
                FilterDialogColumn(
                  title: t.filters.genre,
                  values: _allGenres,
                  pickedValues: _pickedGenres,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
