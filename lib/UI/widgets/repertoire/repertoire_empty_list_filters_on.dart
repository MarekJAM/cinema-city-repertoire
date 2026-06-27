import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/blocs.dart';
import '../../../data/models/models.dart';
import '../../../i18n/strings.g.dart';
import '../../pages/filters_page.dart';
import '../date_selector.dart';
import '../error_column.dart';

class RepertoireEmptyListFiltersOn extends StatelessWidget {
  const RepertoireEmptyListFiltersOn({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorColumn(
      icon: Icons.filter_alt_off_rounded,
      errorMessage: t.repertoire.noFilmsToDisplayPickAnotherDate,
      buttons: [
        ElevatedButton.icon(
          icon: const Icon(Icons.filter_alt_off_rounded),
          onPressed: () {
            final filters = [
              GenreFilter([...genreMap.values, noGenresData]),
              EventTypeFilter(allEventTypes),
              ScoreFilter(0, true),
            ];
            context.read<FiltersCubit>().saveFilters(filters);
            context.read<RepertoireBloc>().add(FiltersChanged(filters));
          },
          label: Text(t.reset),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.tune_rounded),
          onPressed: () {
            Navigator.of(context).push(FiltersPage.route());
          },
          label: Text(t.repertoire.adjustFilters),
        ),
        TextButton.icon(
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () async {
            final date = await DateSelector.selectDate(context);
            if (date == null) return;
            if (context.mounted) {
              context.read<DatesCubit>().selectedDateChanged(date);
            }
          },
          label: Text(t.repertoire.pickDifferentDate),
        ),
      ],
    );
  }
}
