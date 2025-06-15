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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      t.cinemas.pickCinemas,
                      style: TextStyle(fontSize: 24, color: context.colorScheme.primary),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => CinemaItemRow(state.cinemas[index], pickedCinemaIds),
                  itemCount: state.cinemas.length,
                ),
              ),
              Divider(),
              SizedBox(
                width: double.infinity,
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
    return CheckboxListTile(
      value: widget.pickedCinemas.contains(widget.cinemaData.id),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.cinemaData.displayName ?? '',
        softWrap: true,
      ),
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
    );
  }
}
