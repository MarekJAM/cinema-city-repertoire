import 'package:flutter/material.dart';

import '../../../data/models/repertoire.dart';
import '../repertoire_film_item.dart';

class RepertoireListPopulated extends StatelessWidget {
  const RepertoireListPopulated({
    super.key,
    required this.data,
  });

  final Repertoire data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: data.filmItems.length,
          itemBuilder: (ctx, index) {
            return index != data.filmItems.length - 1
                ? RepertoireFilmItemWidget(
                    data.filmItems[index],
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RepertoireFilmItemWidget(
                      data.filmItems[index],
                    ),
                  );
          },
        ),
      );
  }
}
