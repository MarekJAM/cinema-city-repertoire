import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/models/models.dart';
import '../../i18n/strings.g.dart';
import '../../injection.dart';
import '../../utils/date_helper.dart';
import '../../utils/time_zone.dart';
import '../widgets/snackbar.dart';

class FilmEventDialog extends StatefulWidget {
  const FilmEventDialog({
    super.key,
    required this.film,
    required this.cinema,
    required this.item,
  });

  final Film film;
  final String? cinema;
  final Event item;

  @override
  State<FilmEventDialog> createState() => _FilmEventDialogState();
}

class _FilmEventDialogState extends State<FilmEventDialog> {
  Future<void> _launchURL(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _scheduleNotification(String? title, Event event, tz.TZDateTime tzDateTime) async {
    return await di<FlutterLocalNotificationsPlugin>().zonedSchedule(
      int.tryParse(event.id!) ?? 0,
      title,
      t.reminders.filmReminder(
        time: '${event.dateTime.hour}:${event.dateTime.minute == 0 ? "00" : event.dateTime.minute}',
      ),
      tzDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          t.appName,
          channelDescription: 'Cinema City Repertoire Reminder',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = switch (widget.item.language) {
      (LanguageType.dubbing) => t.languageType.dubbing,
      (LanguageType.original) => t.languageType.original,
      (LanguageType.subtitles) => t.languageType.subtitles,
    };
    return Padding(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.film.name,
                  style: TextStyle(fontSize: 24, color: context.colorScheme.primary),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.cancel),
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: const .only(bottom: 3.0),
            child: Text(
              '${widget.cinema!}, ${DateHelper.convertDateToHHMM(widget.item.dateTime)}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const .all(2.0),
            child: Text(
              "$language, ${widget.item.type}",
              style: TextStyle(fontSize: 14, color: context.colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _launchURL(widget.item.bookingLink);
                  },
                  child: Text(
                    t.buyTicket,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    final timeZone = TimeZone();
                    return OutlinedButton(
                      onPressed: timeZone.diffWithCurrentPolishTime(widget.item.dateTime).inMinutes > -30
                          ? null
                          : () async {
                              final eventDateTime = widget.item.dateTime;

                              final pickedTime = await showTimePicker(
                                context: context,
                                initialEntryMode: TimePickerEntryMode.input,
                                helpText: t.reminders.selectReminderTime,
                                initialTime: TimeOfDay.fromDateTime(
                                  widget.item.dateTime.subtract(
                                    const Duration(minutes: 30),
                                  ),
                                ),
                              );

                              if (pickedTime != null) {
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
                                  try {
                                    await _scheduleNotification(
                                      widget.film.name,
                                      widget.item,
                                      pickedTzDateTime,
                                    );
                                    if (context.mounted) {
                                      context.showSnackbar(t.reminders.reminderScheduled);
                                    }
                                    if (context.mounted) Navigator.of(context).pop();
                                  } catch (_) {}
                                }
                              }
                            },
                      child: Text(
                        t.scheduleReminder,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
