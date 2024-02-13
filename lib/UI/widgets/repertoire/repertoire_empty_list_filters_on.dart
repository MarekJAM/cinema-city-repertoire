import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/dates/dates_cubit.dart';
import '../../../i18n/strings.g.dart';
import '../../pages/filters_page.dart';
import '../date_selector.dart';
import '../error_column.dart';

class RepertoireEmptyListFiltersOn extends StatelessWidget {
  const RepertoireEmptyListFiltersOn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorColumn(
      errorMessage: t.repertoire.noFilmsToDisplayPickAnotherDate,
      buttons: [
        ElevatedButton(
          onPressed: () async {
            final date = await DateSelector.selectDate(context);
            if (date == null) return;
            if (context.mounted) {
              context.read<DatesCubit>().selectedDateChanged(date);
            }
          },
          child: Text(
            t.repertoire.pickDifferentDate,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              FiltersPage.route(),
            );
          },
          child: Text(
            t.repertoire.adjustFilters,
          ),
        ),
      ],
    );
  }
}
