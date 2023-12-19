import 'package:flutter/material.dart';

import 'widgets.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: CinemasList(),
    );
  }
}