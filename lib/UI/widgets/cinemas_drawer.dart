import 'package:flutter/material.dart';

import 'widgets.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: CinemasList(),
    );
  }
}