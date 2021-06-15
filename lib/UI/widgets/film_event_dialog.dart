import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/models.dart';
import '../../utils/date_handler.dart';

class FilmEventDialog extends StatelessWidget {
  const FilmEventDialog({
    Key key,
    @required this.film,
    @required this.cinema,
    @required this.item,
  }) : super(key: key);

  final Film film;
  final String cinema;
  final Event item;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${film.name}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                '$cinema',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                DateHandler.convertDateToHHMM(item.dateTime),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "${item.language}, ${item.type}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(
                    "Kup bilet przez stronę",
                  ),
                  onPressed: () {
                    _launchURL(item.bookingLink);
                  },
                ),
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: Text(
                        "Ustaw przypomnienie",
                      ),
                      onPressed: () {},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
