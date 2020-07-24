import 'package:cinema_city/Providers/cinemas.dart';
import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/utils/date_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RepertoireFilmItem extends StatelessWidget {
  final events = Events();
  final cinemas = Cinemas();

  final List<dynamic> data;
  final int index;

  RepertoireFilmItem(this.data, this.index);

  Color _getAgeRestrictionColor(String value) {
    var color;
    if (value == 'NA') {
      color = Colors.green;
    } else if (value == '18') {
      color = Colors.red;
    } else if (int.parse(value) >= 12) {
      color = Colors.yellow[700];
    } else {
      color = Colors.green;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.network(
              data[0][index].posterLink,
              height: deviceSize.height * 0.15,
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    data[0][index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          data[0][index].ageRestriction,
                          style: TextStyle(fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getAgeRestrictionColor(
                              data[0][index].ageRestriction),
                        ),
                      ),
                      for (var item in data[0][index].genres)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3,
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      Text(
                        data[0][index].length.toString() + ' min',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                  ),
                  for (var cinema in data[2])
                    RepertoireFilmItemRow(
                        cinemas: cinemas,
                        cinema: cinema,
                        events: events,
                        data: data,
                        index: index)
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class RepertoireFilmItemRow extends StatelessWidget {
  const RepertoireFilmItemRow({
    Key key,
    @required this.cinemas,
    @required this.cinema,
    @required this.events,
    @required this.data,
    @required this.index,
  }) : super(key: key);

  final Cinemas cinemas;
  final String cinema;
  final Events events;
  final List data;
  final int index;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return events
            .findEventsByFilmId(
                events.findEventsByCinemaId(data[1], cinema), data[0][index].id)
            .isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${cinemas.getCinemaNameById(cinema)}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 3,
                runSpacing: 3,
                children: <Widget>[
                  for (var item in events.findEventsByFilmId(
                      events.findEventsByCinemaId(data[1], cinema),
                      data[0][index].id))
                    GestureDetector(
                      onTap: () => _launchURL(item.bookingLink),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(DateHandler.convertDateToHH_MM(
                                    item.dateTime)),
                                Text(
                                  '${item.type}',
                                  style: TextStyle(fontSize: 7),
                                ),
                                Text(
                                  '${item.language}',
                                  style: TextStyle(fontSize: 7),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 2))
            ],
          )
        : Container();
  }
}
