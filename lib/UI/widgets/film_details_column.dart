import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/film_scores/film_scores_cubit.dart';
import '../../data/models/models.dart';
import '../../i18n/strings.g.dart';
import '../pages/film_details_page.dart';

class FilmDetailsColumn extends StatelessWidget {
  const FilmDetailsColumn({super.key, required this.film, this.isLoading = false});

  final Film film;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      justifyMultiLineText: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailsHeaderRow(
                icon: Icons.calendar_today,
                title: t.filmDetails.premiere,
                content: film.details?.premiereDate,
              ),
              DetailsHeaderRow(
                icon: Icons.timer,
                title: t.filmDetails.filmLength,
                content: t.filmDetails.filmLengthValue(val: "${film.length}"),
              ),
            ],
          ),
          Divider(
            color: context.colorScheme.primary,
            thickness: 2,
          ),
          DetailsDataRow(title: "${t.filmDetails.filmTitle}:", content: film.name),
          if (film.genres.isNotEmpty) const Divider(),
          if (film.genres.isNotEmpty)
            DetailsDataRow(
              title: "${t.filmDetails.filmGenre}:",
              widget: Wrap(
                children: [
                  for (int i = 0; i < film.genres.length; i++)
                    Text(film.genres[i] + (i < film.genres.length - 1 ? ", " : "")),
                ],
              ),
            ),
          if (film.details!.cast.isNotEmpty) const Divider(),
          if (film.details!.cast.isNotEmpty)
            DetailsDataRow(title: "${t.filmDetails.cast}:", content: film.details!.cast),
          if (film.details!.director.isNotEmpty) const Divider(),
          if (film.details!.director.isNotEmpty)
            DetailsDataRow(title: "${t.filmDetails.director}:", content: film.details!.director),
          if (film.details!.production.isNotEmpty) const Divider(),
          if (film.details!.production.isNotEmpty)
            DetailsDataRow(
                title: "${t.filmDetails.production}:", content: film.details!.production),
          const Divider(),
          DetailsDataRow(
            title: "${t.filmDetails.score}:",
            widget: BlocBuilder<FilmScoresCubit, FilmScoresState>(
              builder: (context, state) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset(
                      'assets/filmweb-logo.png',
                      width: 60,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    film.filmWebScore != null || isLoading
                        ? Text(
                            film.filmWebScore ?? t.filmDetails.scoreNoData,
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.5,
                              vertical: 2,
                            ),
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
              },
            ),
          ),
          Divider(
            color: context.colorScheme.primary,
          ),
          if (film.details?.description?.isNotEmpty ?? false) Text(film.details!.description!),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}