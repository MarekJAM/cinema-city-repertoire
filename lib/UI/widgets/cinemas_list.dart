import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../../i18n/strings.g.dart';

class CinemasList extends StatefulWidget {
  const CinemasList({super.key});

  @override
  State<CinemasList> createState() => _CinemasListState();
}

class _CinemasListState extends State<CinemasList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CinemasCubit, CinemasState>(
      buildWhen: (prev, cur) => prev.status != cur.status,
      builder: (context, state) {
        final pickedCinemaIds = [...state.pickedCinemaIds];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Row(
                    children: <Widget>[
                      CinemaItemRow(state.cinemas[index], pickedCinemaIds),
                    ],
                  ),
                  itemCount: state.cinemas.length,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<CinemasCubit>().saveFavoriteCinemas(pickedCinemaIds);
                            context.read<CinemasCubit>().pickCinemas(pickedCinemaIds);
                            context.read<DatesCubit>().getDates(
                                  DateTime.now().add(const Duration(days: 365)),
                                  pickedCinemaIds,
                                );
                            Navigator.of(context).pop();
                          },
                          child: Text(t.apply),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CinemaItemRow extends StatefulWidget {
  final Cinema cinemaData;
  final List<String?> pickedCinemas;

  const CinemaItemRow(this.cinemaData, this.pickedCinemas, {super.key});

  @override
  State<CinemaItemRow> createState() => _CinemaItemRowState();
}

class _CinemaItemRowState extends State<CinemaItemRow> {
  bool? _isChecked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: context.colorScheme.primary,
            value: widget.pickedCinemas.contains(widget.cinemaData.id),
            onChanged: (val) {
              setState(
                () {
                  _isChecked = val;
                  if (_isChecked!) {
                    widget.pickedCinemas.add(widget.cinemaData.id);
                  } else {
                    widget.pickedCinemas.removeWhere((item) => item == widget.cinemaData.id);
                  }
                },
              );
            },
          ),
          Expanded(
            child: Text(
              widget.cinemaData.displayName ?? '',
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
