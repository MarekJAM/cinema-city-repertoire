import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Providers/repertoire.dart';
import 'package:cinema_city/Utils/date_handler.dart';
import 'package:cinema_city/Widgets/repertoire_film_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepertoireScreen extends StatefulWidget {
  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cinema city',
          style: TextStyle(color: Colors.orange),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => setState(() {}),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          FlatButton(
              onPressed: () => _selectDate(context),
              child: Text(
                DateHandler.convertDateToDD_MM(selectedDate),
                style: TextStyle(color: Colors.white),
              ))
        ],
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
          future: Provider.of<Repertoire>(context, listen: false)
              .fetchAndSetRepertoire(
            DateHandler.convertDateToYYYY_MM_DD(
              selectedDate,
            ),
          ),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Consumer<Repertoire>(
                    builder: (ctx, data, child) => Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.separated(
                              itemBuilder: (ctx, index) => RepertoireFilmItem(data.items, index),
                              separatorBuilder: (ctx, index) => Divider(),
                              itemCount: data.items[0].length),
                        ));
              default:
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
