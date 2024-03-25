import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
import '../../i18n/strings.g.dart';
import '../../utils/date_helper.dart';
import '../pages/film_details_page.dart';
import 'widgets.dart';

class RepertoireFilmItemWidget extends StatelessWidget {
  final RepertoireFilmItem data;

  const RepertoireFilmItemWidget(this.data, {Key? key}) : super(key: key);

  Color _getAgeRestrictionColor(String value) {
    final ageLimit = int.tryParse(value) ?? 0;
    if (ageLimit >= 18) {
      return Colors.red;
    } else if (ageLimit >= 12) {
      return Colors.yellow[700]!;
    } else {
      return Colors.green;
    }
  }

  void _goToFilmDetails(BuildContext context, Film film) {
    BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(film);
    Navigator.of(context).push(
      FilmDetailsPage.route(film),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _goToFilmDetails(context, data.film);
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Skeleton.replace(
                        child: Image.network(
                          data.film.posterLink!,
                          errorBuilder: (context, exception, stackTrace) {
                            return const Center(
                              child: Text(
                                'Brak plakatu',
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  FilmWebScoreWrap(data: data),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _goToFilmDetails(context, data.film);
                      },
                      child: Text(
                        data.film.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Skeleton.leaf(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getAgeRestrictionColor(
                                data.film.ageRestriction,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                data.film.ageRestriction,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: Text(
                            t.filmDetails.filmLengthValue(val: '${data.film.length}'),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        for (final item in data.film.genres)
                          Skeleton.leaf(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.grey[700],
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    for (final cinemaItem in data.repertoireFilmCinemaItems)
                      RepertoireFilmItemRow(
                        film: data.film,
                        cinema: cinemaItem.cinema.displayName,
                        events: cinemaItem.events,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilmWebScoreWrap extends StatelessWidget {
  const FilmWebScoreWrap({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RepertoireFilmItem data;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: data.film.filmWebScore == null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.grey[800],
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              data.film.filmWebScore ?? '7.7 / 10',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class RepertoireFilmItemRow extends StatelessWidget {
  const RepertoireFilmItemRow({
    Key? key,
    required this.film,
    required this.events,
    required this.cinema,
  }) : super(key: key);

  final Film film;
  final List<Event> events;
  final String? cinema;

  @override
  Widget build(BuildContext context) {
    return events.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cinema!,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 4,
                runSpacing: 4,
                children: <Widget>[
                  for (var item in events)
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilmEventDialog(film: film, cinema: cinema, item: item);
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.primary),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              children: [
                                Text(DateHelper.convertDateToHHMM(item.dateTime)),
                                Text(
                                  item.type!,
                                  style: const TextStyle(fontSize: 7),
                                ),
                                Text(
                                  switch (item.language) {
                                    (LanguageType.dubbing) => t.languageType.dubbing,
                                    (LanguageType.original) => t.languageType.original,
                                    (LanguageType.subtitles) => t.languageType.subtitles,
                                  },
                                  style: const TextStyle(fontSize: 7),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
              ),
            ],
          )
        : Container();
  }
}
