import 'package:flutter/material.dart';

import 'widgets.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    Key? key,
  }) : super(key: key);

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
              deviceSize.height - headerHeight,
            ),
          ],
        ),
      ),
    );
  }
}