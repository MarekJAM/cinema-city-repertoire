import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';

class CinemasList extends StatefulWidget {
  final double height;

  const CinemasList(this.height, {Key? key}) : super(key: key);

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
        return SizedBox(
          height: widget.height,
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
                height: widget.height * 0.9,
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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          context.read<CinemasCubit>().pickCinemas(pickedCinemaIds);
                          context.read<DatesCubit>().getDates(
                              DateTime.now().add(const Duration(days: 365)), pickedCinemaIds);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Wyświetl'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          context.read<CinemasCubit>().saveFavoriteCinemas(pickedCinemaIds);
                          if (Platform.isAndroid || Platform.isIOS) {
                            Fluttertoast.showToast(
                              msg: "Zapisano kina jako ulubione.",
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Zapisano kina jako ulubione.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Zapisz'),
                      ),
                    ],
                  ),
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

  const CinemaItemRow(this.cinemaData, this.pickedCinemas, {Key? key}) : super(key: key);

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
            activeColor: Theme.of(context).colorScheme.secondary,
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
              widget.cinemaData.displayName!,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
