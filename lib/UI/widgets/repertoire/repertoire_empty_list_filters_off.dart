import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/dates/dates_cubit.dart';
import '../../../i18n/strings.g.dart';
import '../date_selector.dart';
import '../error_column.dart';

class RepertoireEmptyListFiltersOff extends StatelessWidget {
  const RepertoireEmptyListFiltersOff({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorColumn(
        errorMessage: t.repertoire.noFilmsToDisplay,
        buttonMessage: t.repertoire.pickDifferentDate,
        buttonOnPressed: () async {
          final date = await DateSelector.selectDate(context);
          if (date == null) return;
          if (context.mounted) {
            context
                .read<DatesCubit>()
                .selectedDateChanged(date);
          }
        },
      );
  }
}