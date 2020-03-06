import 'package:flutter/material.dart';

class Event {
  final String id;
  final String filmId;
  final String cinemaId;
  final DateTime dateTime;
  final String type;
  final String language;
  final String bookingLink;

  Event({
    @required this.id,
    @required this.filmId,
    @required this.cinemaId,
    @required this.dateTime,
    @required this.language,
    @required this.type,
    @required this.bookingLink,
  });
}
