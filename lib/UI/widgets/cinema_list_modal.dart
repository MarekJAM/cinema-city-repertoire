import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/models.dart';
import '../../bloc/repertoire/bloc.dart';


class CinemasModal extends StatelessWidget {
  final List<Cinema> list;
  List<String> pickedCinemas;
  final DateTime pickedDate;

  CinemasModal(this.list, this.pickedDate, this.pickedCinemas);

  _saveCinemas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cinemas', pickedCinemas);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  CinemaModalRow(list[index], pickedCinemas),
                ],
              ),
              itemCount: list.length,
            ),
          ),
          Row(
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
                onPressed: () {
                  _saveCinemas();
                },
                child: Text('Zapisz'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CinemaModalRow extends StatefulWidget {
  final Cinema cinemaData;
  final List<String> pickedCinemas;

  CinemaModalRow(this.cinemaData, this.pickedCinemas);

  @override
  _CinemaModalRowState createState() => _CinemaModalRowState();
}

class _CinemaModalRowState extends State<CinemaModalRow> {
  bool _isChecked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: widget.pickedCinemas.contains(widget.cinemaData.id),
            onChanged: (val) {
              setState(() {
                _isChecked = val;
                if (_isChecked) {
                  widget.pickedCinemas.add(widget.cinemaData.id);
                } else {
                  widget.pickedCinemas
                      .removeWhere((item) => item == widget.cinemaData.id);
                }
              });
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
