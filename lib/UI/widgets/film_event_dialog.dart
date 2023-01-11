import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/models/models.dart';
import '../../utils/date_helper.dart';
import '../../utils/time_zone.dart';
import '../../utils/toast_helper.dart';

class FilmEventDialog extends StatefulWidget {
  const FilmEventDialog({
    Key? key,
    required this.film,
    required this.cinema,
    required this.item,
  }) : super(key: key);

  final Film film;
  final String? cinema;
  final Event item;

  @override
  State<FilmEventDialog> createState() => _FilmEventDialogState();
}

class _FilmEventDialogState extends State<FilmEventDialog> {
  late FlutterLocalNotificationsPlugin localNotification;

  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _scheduleNotification(String? title, Event event, tz.TZDateTime tzDateTime) async {
    await localNotification.zonedSchedule(
      int.tryParse(event.id!) ?? 0,
      title,
      'Przypomnienie o seansie - ${event.dateTime.hour}:${event.dateTime.minute == 0 ? "00" : event.dateTime.minute}',
      tzDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'Cinema City Repertuar',
          channelDescription: 'Cinema City Repertuar Powiadomienie',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    if (!mounted) return;
    ToastHelper.show(context, "Zaplanowano przypomnienie.", Colors.green);
  }

  @override
  void initState() {
    super.initState();

    var initializationAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationAndroid);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.film.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                widget.cinema!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                DateHelper.convertDateToHHMM(widget.item.dateTime),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "${widget.item.language}, ${widget.item.type}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text(
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
                      child: const Text(
                        "Ustaw przypomnienie",
                      ),
                      onPressed: () async {
                        final eventDateTime = widget.item.dateTime;

                        final pickedTime = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          helpText: "Wybierz godzinę przypomnienia",
                          initialTime: TimeOfDay.fromDateTime(
                            widget.item.dateTime.subtract(
                              const Duration(minutes: 30),
                            ),
                          ),
                        );

                        if (pickedTime != null) {
                          final timeZone = TimeZone();
                          final timeZoneName = await timeZone.getTimeZoneName();

                          final location = await timeZone.getLocation(timeZoneName);

                          final pickedTzDateTime = tz.TZDateTime(
                            location,
                            eventDateTime.year,
                            eventDateTime.month,
                            eventDateTime.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          if (pickedTzDateTime.isAfter(tz.TZDateTime.now(location))) {
                            _scheduleNotification(
                              widget.film.name,
                              widget.item,
                              pickedTzDateTime,
                            );
                          } else {
                            if (!mounted) return;
                            ToastHelper.show(context, 'Ustawiono przypomnienie', Colors.green);
                          }
                        }
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
