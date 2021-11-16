import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../../utils/date_handler.dart';
import '../screens/film_details_screen.dart';
import 'widgets.dart';

class RepertoireFilmItem extends StatelessWidget {
  final Map<String, dynamic> data;

  RepertoireFilmItem(this.data);

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
    final cinemas = data.keys.where((element) => element != "film").toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(data['film']);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => FilmDetailsScreen(
                      film: data['film'],
                    ),
                  ),
                );
              },
              child: Image.network(
                data['film'].posterLink,
                height: deviceSize.height * 0.15,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    data['film'].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          data['film'].ageRestriction,
                          style: TextStyle(fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getAgeRestrictionColor(
                            data['film'].ageRestriction,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Text(
                          data['film'].length.toString() + ' min',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      for (var item in data['film'].genres)
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                  ),
                  for (var cinema in cinemas)
                    RepertoireFilmItemRow(
                      film: data["film"],
                      cinema: cinema,
                      events: data[cinema],
                    ),
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
    @required this.film,
    @required this.events,
    @required this.cinema,
  }) : super(key: key);

  final Film film;
  final List<Event> events;
  final String cinema;

  @override
  Widget build(BuildContext context) {
    return events.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$cinema',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 3,
                runSpacing: 3,
                children: <Widget>[
                  for (var item in events)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilmEventDialog(film: film, cinema: cinema, item: item);
                          },
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(DateHandler.convertDateToHHMM(item.dateTime)),
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
                              border: Border.all(color: Theme.of(context).accentColor),
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
              Padding(
                padding: EdgeInsets.only(bottom: 2),
              ),
            ],
          )
        : Container();
  }
}
