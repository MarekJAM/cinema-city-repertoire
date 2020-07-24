import 'package:cinema_city/Models/cinema.dart';
import 'package:cinema_city/Providers/cinemas.dart';
import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Providers/repertoire.dart';
import 'package:cinema_city/utils/date_handler.dart';
import 'package:cinema_city/Widgets/cinema_list_modal.dart';
import 'package:cinema_city/Widgets/repertoire_film_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepertoireScreen extends StatefulWidget {
  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  var todayDate = DateTime.now();
  var selectedDate = DateTime.now();
  var dateInAYear = DateTime.now().add(new Duration(days: 365));
  List<String> pickedCinemas = [];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(todayDate.year, todayDate.month, todayDate.day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void showCinemaListModal(
      BuildContext context, List<Cinema> data, DateTime dateTime) {
    Dialog cinemaDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: CinemasModal(data, dateTime, pickedCinemas),
    );
    showDialog(
        context: context, builder: (BuildContext context) => cinemaDialog);
  }

  Future<void> _refreshRepertoire(BuildContext context) async {
    Provider.of<Repertoire>(context, listen: false).fetchAndSetRepertoire(
        DateHandler.convertDateToYYYY_MM_DD(
          selectedDate,
        ),
        pickedCinemas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cinema city',
          style: TextStyle(color: Colors.orange, fontSize: 22),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Center(
                child: Text(
                  DateHandler.convertDateToDD_MM(selectedDate),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: Provider.of<Cinemas>(context, listen: false)
                  .fetchAndSetCinemas(
                DateHandler.convertDateToYYYY_MM_DD(
                  dateInAYear,
                ),
              ),
              builder: (ctx, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.data != null) {
                      return Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () => showCinemaListModal(
                              context, snapshot.data, selectedDate),
                          child: Center(
                            child: Icon(
                              Icons.local_movies,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    break;

                  default:
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.local_movies,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                }
              })
        ],
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
          future: _refreshRepertoire(context),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.error == null) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshRepertoire(context),
                    child: Consumer<Repertoire>(
                        builder: (ctx, data, child) => data.items.isNotEmpty
                            ? data.items[0].length > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: ListView.separated(
                                        itemBuilder: (ctx, index) =>
                                            RepertoireFilmItem(
                                                data.items, index),
                                        separatorBuilder: (ctx, index) =>
                                            Divider(),
                                        itemCount: data.items[0].length),
                                  )
                                : Center(
                                    child: Text('Brak seansów.'),
                                  )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                  );
                } else {
                  return Center(
                    child: Text('Ups, coś poszło nie tak!'),
                  );
                }
                break;

              default:
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
