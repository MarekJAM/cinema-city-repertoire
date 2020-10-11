import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/models/models.dart';
import '../../bloc/repertoire/bloc.dart';
import '../../utils/storage.dart';

class CinemasList extends StatelessWidget {
  final List<Cinema> list;
  final List<String> pickedCinemas;
  final DateTime pickedDate;
  final double height;

  CinemasList(this.list, this.pickedDate, this.pickedCinemas, this.height);

  Future<void> _saveFavoriteCinemas() async {
    await Storage.setFavoriteCinemas(pickedCinemas);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            height: height * 0.9,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  CinemaItemRow(list[index], pickedCinemas),
                ],
              ),
              itemCount: list.length,
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
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<RepertoireBloc>(context).add(
                        FetchRepertoire(pickedDate, pickedCinemas),
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Wyświetl'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      await _saveFavoriteCinemas();
                      Fluttertoast.showToast(
                          msg: "Zapisano kina jako ulubione.",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Text('Zapisz'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CinemaItemRow extends StatefulWidget {
  final Cinema cinemaData;
  final List<String> pickedCinemas;

  CinemaItemRow(this.cinemaData, this.pickedCinemas);

  @override
  _CinemaItemRowState createState() => _CinemaItemRowState();
}

class _CinemaItemRowState extends State<CinemaItemRow> {
  bool _isChecked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: widget.pickedCinemas.contains(widget.cinemaData.id),
            onChanged: (val) {
              setState(
                () {
                  _isChecked = val;
                  if (_isChecked) {
                    widget.pickedCinemas.add(widget.cinemaData.id);
                  } else {
                    widget.pickedCinemas
                        .removeWhere((item) => item == widget.cinemaData.id);
                  }
                },
              );
            },
          ),
          Expanded(
            child: Text(
              widget.cinemaData.displayName,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
