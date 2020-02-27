import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Providers/repertoire.dart';
import 'package:cinema_city/Utils/date_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepertoireScreen extends StatefulWidget {
  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  DateTime selectedDate = DateTime.now();
  var events = new Events();

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
    final deviceSize = MediaQuery.of(context).size;
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
                              itemBuilder: (ctx, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Image.network(
                                          data.items[0][index].posterLink,
                                          height: deviceSize.height * 0.15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                data.items[0][index].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      data.items[0][index]
                                                          .ageRestriction,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  for (var item in data
                                                      .items[0][index].genres)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 3,
                                                      ),
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 3,
                                                        ),
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(5),
                                                          ),
                                                          color: Colors.black12,
                                                        ),
                                                      ),
                                                    ),
                                                  Text(
                                                    data.items[0][index].length
                                                            .toString() +
                                                        ' min',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                              Wrap(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.start,
                                                spacing: 3,
                                                children: <Widget>[
                                                  for (var item in events
                                                      .findEventsByFilmId(
                                                          data.items[1],
                                                          data.items[0][index]
                                                              .id))
                                                    Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(DateHandler
                                                              .convertDateToHH_MM(
                                                                  item.dateTime))
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        )
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
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
