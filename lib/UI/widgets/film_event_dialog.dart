import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/models.dart';
import '../../utils/date_handler.dart';

class FilmEventDialog extends StatefulWidget {
  const FilmEventDialog({
    Key key,
    @required this.film,
    @required this.cinema,
    @required this.item,
  }) : super(key: key);

  final Film film;
  final String cinema;
  final Event item;

  @override
  _FilmEventDialogState createState() => _FilmEventDialogState();
}

class _FilmEventDialogState extends State<FilmEventDialog> {
  FlutterLocalNotificationsPlugin localNotification;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('channelId', 'Local notification', 'Just a test',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await localNotification.show(22, title, body, platformChannelSpecifics);
  }

  @override
  void initState() {
    super.initState();

    var initializationAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationAndroid);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
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
              '${widget.film.name}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                '${widget.cinema}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                DateHandler.convertDateToHHMM(widget.item.dateTime),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "${widget.item.language}, ${widget.item.type}",
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
                    _launchURL(widget.item.bookingLink);
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
                      onPressed: () {
                        _showNotification(
                          '${widget.film.name}',
                          '${widget.item.dateTime.month}.${widget.item.dateTime.day} - ${widget.item.dateTime.hour}:${widget.item.dateTime.minute}',
                        );
                      },
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
