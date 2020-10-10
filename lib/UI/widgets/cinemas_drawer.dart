import 'package:flutter/material.dart';

import 'widgets.dart';
import '../../data/models/models.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    @required this.pickedDate,
    @required this.pickedCinemas,
    @required this.cinemas,
  });

  final DateTime pickedDate;
  final List<String> pickedCinemas;
  final List<Cinema> cinemas;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final double headerHeight = 100;

    return Drawer(
      child: Container(
        height: deviceSize.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: headerHeight,
              child: DrawerHeader(
                child: Text(
                  'Kina',
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ),
            Container(
              child: CinemasList(
                cinemas,
                pickedDate,
                pickedCinemas,
                deviceSize.height - headerHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
