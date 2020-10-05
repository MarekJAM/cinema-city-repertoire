import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/cinemas/bloc.dart';
import '../../bloc/repertoire/bloc.dart';
import '../../utils/date_handler.dart';
import '../widgets/cinema_list_modal.dart';
import '../widgets/repertoire_film_item.dart';

class RepertoireScreen extends StatefulWidget {
  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  var todayDate = DateTime.now();
  var pickedDate = DateTime.now();
  var dateInAYear = DateTime.now().add(new Duration(days: 365));
  List<String> pickedCinemas = [];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(todayDate.year, todayDate.month, todayDate.day),
        lastDate: DateTime(2101));
    if (picked != null && picked != pickedDate) {
      pickedDate = picked;
      setState(() {
        BlocProvider.of<RepertoireBloc>(context).add(
          FetchRepertoire(
            pickedDate,
            pickedCinemas,
          ),
        );
      });
    }
  }

  void showCinemaListModal(
    BuildContext context,
    List<Cinema> data,
    DateTime dateTime,
  ) {
    Dialog cinemaDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: CinemasModal(data, dateTime, pickedCinemas),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => cinemaDialog,
    );
  }

  Future<void> _refreshRepertoire() async {
    BlocProvider.of<RepertoireBloc>(context).add(
      FetchRepertoire(
        pickedDate,
        pickedCinemas,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
              child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Cinema city',
          style: TextStyle(color: Colors.orange, fontSize: 22),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Center(
                child: Text(
                  DateHandler.convertDateToDD_MM(pickedDate),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          BlocBuilder<CinemasBloc, CinemasState>(builder: (ctx, state) {
            if (state is CinemasLoaded) {
              if (state.data != null) {
                return Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () =>
                        showCinemaListModal(context, state.data, pickedDate),
                        // Scaffold.of(ctx).openEndDrawer(),
                    child: Center(
                      child: Icon(
                        Icons.local_movies,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            }
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
          })
        ],
        backgroundColor: Colors.black,
      ),
      body: BlocListener<CinemasBloc, CinemasState>(
        listener: (context, state) {
          if (state is CinemasLoaded) {
            BlocProvider.of<RepertoireBloc>(context).add(
              FetchRepertoire(pickedDate, pickedCinemas),
            );
          }
        },
        child: BlocBuilder<RepertoireBloc, RepertoireState>(
          builder: (_, state) {
            if (state is RepertoireLoaded) {
              return RefreshIndicator(
                onRefresh: () => _refreshRepertoire(),
                child: state.data.items.length != 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ListView.separated(
                          separatorBuilder: (ctx, index) => Divider(),
                          itemCount: state.data.items.length,
                          itemBuilder: (ctx, index) {
                            return RepertoireFilmItem(state.data.items[index]);
                          },
                        ),
                      )
                    : Center(
                        child: Text('Brak filmów do wyświetlenia.'),
                      ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
