import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../utils/date_helper.dart';
import '../screens/filters_screen.dart';
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
        title: RichText(
          text: TextSpan(
            children: const [
              TextSpan(text: 'Cinema City\n'),
              TextSpan(text: 'Repertuar', style: TextStyle(fontSize: 16)),
            ],
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 22),
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
                if (!mounted || date == null) return;
                context.read<DatesCubit>().selectedDateChanged(date);
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
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      enabled: state.status.isSuccess,
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: const Text("Kina"),
                    ),
                    PopupMenuItem<String>(
                      child: const Text("Filtry"),
                      onTap: () async {
                        await Future.delayed(const Duration(microseconds: 3));
                        if (!mounted) return;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const FiltersScreen(),
                          ),
                        );
                      },
                    ),
                  ];
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
    );
  }
}
