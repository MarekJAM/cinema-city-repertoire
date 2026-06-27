import 'package:flutter/material.dart';

import '../../../data/models/repertoire.dart';
import '../repertoire_film_item.dart';

class RepertoireListPopulated extends StatelessWidget {
  const RepertoireListPopulated({super.key, required this.data});

  final Repertoire data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: data.filmItems.length,
      itemBuilder: (ctx, index) {
        return RepertoireFilmItemWidget(data.filmItems[index]);
      },
    );
  }
}
