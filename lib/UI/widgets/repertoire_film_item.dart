import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_city/UI/widgets/rating_bar.dart';
import 'package:cinema_city/utils/theme_context_extensions.dart';
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

  const RepertoireFilmItemWidget(this.data, {super.key});

  void _goToFilmDetails(BuildContext context, Film film) {
    BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(film);
    Navigator.of(context).push(
      FilmDetailsPage.route(film),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.surfaceContainerLow,
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
                        child: CachedNetworkImage(
                          imageUrl: data.film.posterLink!,
                          errorWidget: (context, url, error) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image_not_supported_rounded),
                                  Text(
                                    t.filmDetails.posterError,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
                      runSpacing: 3,
                      children: <Widget>[
                        if (data.film.ageRestriction != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Skeleton.leaf(
                              child: FilmAgeRestrictionIndicator(data.film.ageRestriction!),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[700] ?? Colors.grey),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              t.filmDetails.filmLengthValue(val: '${data.film.length}'),
                              style: const TextStyle(fontSize: 10),
                            ),
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
    super.key,
    required this.data,
  });

  final RepertoireFilmItem data;

  @override
  Widget build(BuildContext context) {
    return switch (data.film.rating) {
      FilmRatingError() => const SizedBox.shrink(),
      FilmRatingLoaded(rating: final rating) => RatingBar(rating: rating, maxRating: 10),
      FilmRatingLoading() || FilmRatingInitial() => const RatingBarSkeleton(),
    };
  }
}

class RepertoireFilmItemRow extends StatelessWidget {
  const RepertoireFilmItemRow({
    super.key,
    required this.film,
    required this.events,
    required this.cinema,
  });

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
                              border: Border.all(color: context.colorScheme.primary),
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
