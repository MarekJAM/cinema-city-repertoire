import 'package:cinema_city/Models/cinema.dart';
import 'package:cinema_city/Providers/cinemas.dart';
import 'package:cinema_city/Providers/repertoire.dart';
import 'package:cinema_city/utils/date_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CinemasModal extends StatelessWidget {
  final List<Cinema> list;
  List<String> pickedCinemas;
  final DateTime dateTime;

  CinemasModal(this.list, this.dateTime, this.pickedCinemas);

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
                  Provider.of<Repertoire>(context, listen: false)
                      .fetchAndSetRepertoire(
                          DateHandler.convertDateToYYYY_MM_DD(
                            dateTime,
                          ),
                          pickedCinemas);
                  Navigator.of(context).pop();
                },
                child: Text('Wyświetl'),
              ),
              RaisedButton(
                onPressed: () {
                  _saveCinemas();
                  print('zapisano');
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
