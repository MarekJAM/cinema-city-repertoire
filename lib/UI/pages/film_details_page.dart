import 'package:cinema_city/UI/widgets/widgets.dart';
import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../data/models/film.dart';
import '../../i18n/strings.g.dart';
import '../widgets/film_details_column.dart';

class FilmDetailsPage extends StatelessWidget {
  final Film film;

  const FilmDetailsPage({super.key, required this.film});

  static Route<void> route(Film film) {
    return MaterialPageRoute(
      builder: (BuildContext context) => FilmDetailsPage(
        film: film,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilmDetailsView(film: film);
  }
}

class FilmDetailsView extends StatelessWidget {
  final Film film;

  const FilmDetailsView({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height,
          color: context.colorScheme.surface,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: SliverHeader(
                  imageUrl: film.posterLink ?? "",
                  videoUrl: film.videoLink,
                  maxExtent: 450,
                  minExtent: 0,
                ),
              ),
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: context.colorScheme.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: BlocBuilder<FilmDetailsCubit, FilmDetailsState>(
                        builder: (context, state) {
                          return switch (state) {
                            FilmDetailsLoading() =>
                              FilmDetailsColumn(film: Film.mock, isLoading: true),
                            FilmDetailsLoaded() => FilmDetailsColumn(film: state.film),
                            FilmDetailsError() => ErrorColumn(
                                errorMessage: state.message,
                                buttonMessage: t.refresh,
                                buttonOnPressed: () {
                                  BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(film);
                                },
                              ),
                          };
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsHeaderRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;

  const DetailsHeaderRow({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 35,
        ),
        const SizedBox(
          width: 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title: ",
              style: const TextStyle(fontSize: 12),
            ),
            Wrap(
              children: [
                Text(
                  content!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class DetailsDataRow extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? widget;

  const DetailsDataRow({super.key, required this.title, this.content, this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(title),
        ),
        Expanded(
          child: content != null ? Text(content!) : widget!,
        )
      ],
    );
  }
}
