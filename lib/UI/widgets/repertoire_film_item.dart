import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(data.film);
                Navigator.of(context).push(
                  FilmDetailsPage.route(data.film),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
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
                  const SizedBox(
                    height: 2,
                  ),
                  FilmWebScoreWrap(data: data),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.film.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 1),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Container(
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3,
                          ),
                          child: Text(
                            '${data.film.length} min',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        for (var item in data.film.genres)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                            ),
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
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    for (var cinemaItem in data.repertoireFilmCinemaItems)
                      RepertoireFilmItemRow(
                        film: data.film,
                        cinema: cinemaItem.cinema.displayName,
                        events: cinemaItem.events,
                      ),
                  ],
                ),
              ),
            )
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
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          'assets/filmweb-logo.png',
          width: 50,
        ),
        const SizedBox(
          width: 5,
        ),
        data.film.filmWebScore != null
            ? Text(
                data.film.filmWebScore ?? 'no data',
                style: const TextStyle(fontSize: 12),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5, vertical: 2),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
      ],
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
                spacing: 3,
                runSpacing: 3,
                children: <Widget>[
                  for (var item in events)
                    GestureDetector(
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
                              border: Border.all(color: Theme.of(context).colorScheme.secondary),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(DateHelper.convertDateToHHMM(item.dateTime)),
                                Text(
                                  item.type!,
                                  style: const TextStyle(fontSize: 7),
                                ),
                                Text(
                                  item.language!,
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
                padding: EdgeInsets.only(bottom: 2),
              ),
            ],
          )
        : Container();
  }
}
