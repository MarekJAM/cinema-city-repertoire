import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cinemas/bloc.dart';
import 'widgets.dart';

class CinemasDrawer extends StatelessWidget {
  const CinemasDrawer({
    @required this.pickedDate,
    @required this.pickedCinemas,
  });

  final DateTime pickedDate;
  final List<String> pickedCinemas;

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
            BlocBuilder<CinemasBloc, CinemasState>(builder: (context, state) {
              if (state is CinemasLoaded) {
                return Container(
                  child: CinemasList(
                    state.data,
                    pickedDate,
                    pickedCinemas,
                    deviceSize.height - headerHeight
                  ),
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
