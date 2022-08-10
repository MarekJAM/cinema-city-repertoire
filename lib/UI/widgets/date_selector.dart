import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../utils/date_helper.dart';

class DateSelector {
  static Future<DateTime?> selectDate(BuildContext context) async {
    final todayDate = DateTime.now();
    final selectableDates = context.read<DatesCubit>().state.dates;
    final pickedDate = context.read<DatesCubit>().state.selectedDate;

    return await showDatePicker(
      context: context,
      initialDate: selectableDates.isEmpty
          ? pickedDate
          : selectableDates.any((el) => el.isSameDate(pickedDate))
              ? pickedDate
              : selectableDates[0],
      firstDate: DateTime(todayDate.year, todayDate.month, todayDate.day),
      lastDate: DateTime(2101),
      selectableDayPredicate: (date) {
        return DateHelper.decideWhichDayToEnable(date, selectableDates);
      },
    );
  }
}