import 'package:flutter/material.dart';

import 'widgets.dart';
import '../../data/models/models.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    Key? key,
    required this.pickedDate,
    required this.pickedCinemas,
    required this.cinemas,
  }) : super(key: key);

  final DateTime? pickedDate;
  final List<String> pickedCinemas;
  final List<Cinema> cinemas;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    const double headerHeight = 100;

    return Drawer(
      child: SizedBox(
        height: deviceSize.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: headerHeight,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text(
                  'Kina',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            CinemasList(
              cinemas,
              pickedDate,
              pickedCinemas,
              deviceSize.height - headerHeight,
            ),
          ],
        ),
      ),
    );
  }
}
