import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../i18n/strings.g.dart';
import '../../utils/date_helper.dart';
import '../pages/filters_page.dart';
import 'date_selector.dart';

class RepertoireAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RepertoireAppBar({Key? key}) : super(key: key);

  @override
  State<RepertoireAppBar> createState() => _RepertoireAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _RepertoireAppBarState extends State<RepertoireAppBar> {
  @override
  Widget build(BuildContext context) {
    final datesCubit = context.watch<DatesCubit>();

    return BlocListener<DatesCubit, DatesState>(
      listenWhen: (previous, current) =>
          previous.status.isSuccess && previous.selectedDate != current.selectedDate,
      listener: (context, state) {
        context.read<RepertoireBloc>().add(GetRepertoire(date: state.selectedDate));
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
            children: const [
              TextSpan(text: 'Cinema City\n'),
              TextSpan(text: 'Repertuar', style: TextStyle(fontSize: 16)),
            ],
            style: TextStyle(color: context.colorScheme.primary, fontSize: 22),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).indicatorColor,
                ),
              ),
              child: Text(
                DateHelper.convertDateToDDMM(datesCubit.state.selectedDate),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final date = await DateSelector.selectDate(context);
                if (date == null) return;
                if (context.mounted) context.read<DatesCubit>().selectedDateChanged(date);
              },
            ),
          ),
          BlocConsumer<CinemasCubit, CinemasState>(
            listenWhen: (prev, cur) => prev.status.isLoading && cur.status.isSuccess,
            listener: (context, state) {
              if (state.status.isSuccess) {
                BlocProvider.of<DatesCubit>(context)
                    .getDates(DateHelper.getDateTimeInAYear, state.favoriteCinemaIds);
              }
            },
            builder: (ctx, state) {
              return PopupMenuButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      enabled: state.status.isSuccess,
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: Text(t.cinemas.name),
                    ),
                    PopupMenuItem<String>(
                      child: Text(t.filters.name),
                      onTap: () async {
                        await Future.delayed(const Duration(microseconds: 3));
                        if (!context.mounted) return;
                        Navigator.of(context).push(
                          FiltersPage.route(),
                        );
                      },
                    ),
                  ];
                },
              );
            },
          ),
        ],
        backgroundColor: context.colorScheme.background,
      ),
    );
  }
}
