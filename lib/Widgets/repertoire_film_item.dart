import 'package:cinema_city/Providers/events.dart';
import 'package:cinema_city/Utils/date_handler.dart';
import 'package:flutter/material.dart';

class RepertoireFilmItem extends StatelessWidget {
  final events = new Events();

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
      color = Colors.yellow;
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
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 3,
                    runSpacing: 3,
                    children: <Widget>[
                      for (var item in events.findEventsByFilmId(
                          data[1], data[0][index].id))
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
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                    ],
                  )
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
