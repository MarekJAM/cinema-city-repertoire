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
    Navigator.of(context).push(FilmDetailsPage.route(film));
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
                  FilmPoster(imageUrl: data.film.posterLink),
                  const SizedBox(height: 2),
                  FilmWebScoreWrap(data: data),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const .only(left: 8),
                child: Column(
                  crossAxisAlignment: .start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _goToFilmDetails(context, data.film);
                      },
                      child: Text(
                        data.film.name,
                        style: const TextStyle(fontWeight: .bold),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      crossAxisAlignment: .center,
                      runSpacing: 3,
                      children: <Widget>[
                        if (data.film.ageRestriction != null)
                          Padding(
                            padding: const .only(right: 4),
                            child: Skeleton.leaf(
                              child: FilmAgeRestrictionIndicator(
                                data.film.ageRestriction!,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const .only(right: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              border: .all(
                                color: context.colorScheme.outlineVariant,
                              ),
                              borderRadius: const BorderRadius.all(
                                .circular(5),
                              ),
                            ),
                            child: Text(
                              t.filmDetails.filmLengthValue(
                                val: '${data.film.length}',
                              ),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        for (final item in data.film.genres)
                          Skeleton.leaf(
                            child: Padding(
                              padding: const .only(right: 4),
                              child: Container(
                                padding: const .symmetric(
                                  horizontal: 3,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const .all(.circular(5)),
                                  color: context
                                      .colorScheme
                                      .surfaceContainerHighest,
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
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

class FilmPoster extends StatelessWidget {
  const FilmPoster({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 80,
      child: ClipRRect(
        borderRadius: .circular(5),
        child: Skeleton.replace(
          child: imageUrl == null
              ? const FilmPosterFallback()
              : CachedNetworkImage(
                  imageUrl: imageUrl!,
                  errorWidget: (context, url, error) =>
                      const FilmPosterFallback(),
                ),
        ),
      ),
    );
  }
}

class FilmPosterFallback extends StatelessWidget {
  const FilmPosterFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Icon(Icons.image_not_supported_rounded),
          Text(t.filmDetails.posterError, textAlign: .center),
        ],
      ),
    );
  }
}

class FilmWebScoreWrap extends StatelessWidget {
  const FilmWebScoreWrap({super.key, required this.data});

  final RepertoireFilmItem data;

  @override
  Widget build(BuildContext context) {
    return switch (data.film.rating) {
      FilmRatingError() => const SizedBox.shrink(),
      FilmRatingLoaded(rating: final rating) => RatingBar(
        rating: rating,
        maxRating: 10,
      ),
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
        ? Padding(
            padding: const .only(top: 4, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cinema ?? '',
                  style: TextStyle(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: .w600,
                  ),
                ),
                const SizedBox(height: 3),
                Wrap(
                  direction: .horizontal,
                  alignment: .start,
                  spacing: 5,
                  runSpacing: 5,
                  children: <Widget>[
                    for (var item in events)
                      Material(
                        color: context.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.55),
                        clipBehavior: .antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(6),
                          side: BorderSide(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: .circular(6),
                          ),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return FilmEventDialog(
                                  film: film,
                                  cinema: cinema,
                                  item: item,
                                );
                              },
                            );
                          },
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Container(
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.75),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 4,
                                  ),
                                  child: Column(
                                    mainAxisSize: .min,
                                    children: [
                                      SizedBox(
                                        width: 44,
                                        child: Text(
                                          DateHelper.convertDateToHHMM(
                                            item.dateTime,
                                          ),
                                          textAlign: .center,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            color:
                                                context.colorScheme.onSurface,
                                            fontSize: 13,
                                            fontWeight: .w700,
                                            fontFeatures: const [
                                              FontFeature.tabularFigures(),
                                            ],
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      if (item.type != null)
                                        Padding(
                                          padding: const .only(
                                            top: 1,
                                            bottom: 1,
                                          ),
                                          child: Text(
                                            item.type!,
                                            style: TextStyle(
                                              color: context
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                              fontSize: 8,
                                              fontWeight: .w600,
                                              height: 1.15,
                                            ),
                                          ),
                                        ),
                                      Text(
                                        switch (item.language) {
                                          (LanguageType.dubbing) =>
                                            t.languageType.dubbing,
                                          (LanguageType.original) =>
                                            t.languageType.original,
                                          (LanguageType.subtitles) =>
                                            t.languageType.subtitles,
                                        },
                                        style: TextStyle(
                                          color: context
                                              .colorScheme
                                              .onSurfaceVariant,
                                          fontSize: 8,
                                          fontWeight: .w600,
                                          height: 1.15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}
