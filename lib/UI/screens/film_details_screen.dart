import 'package:cinema_city/UI/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../data/models/film.dart';

class FilmDetailsScreen extends StatelessWidget {
  final Film film;

  const FilmDetailsScreen({@required this.film});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height,
          color: Theme.of(context).primaryColor,
          child: BlocBuilder<FilmDetailsCubit, FilmDetailsState>(
            builder: (context, state) {
              if (state is FilmDetailsLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: SliverHeader(
                        imageUrl: film.posterLink.replaceAll("md.jpg", "lg.jpg"),
                        videoUrl: film.videoLink,
                        maxExtent: 450,
                        minExtent: 0,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.grey[900],
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    DetailsHeaderRow(
                                      icon: Icons.calendar_today,
                                      title: "Premiera",
                                      content: film.details.premiereDate,
                                    ),
                                    DetailsHeaderRow(
                                      icon: Icons.timer,
                                      title: "Czas trwania",
                                      content: "${film.length} min",
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Theme.of(context).colorScheme.secondary,
                                  thickness: 2,
                                ),
                                DetailsDataRow(title: "Tytuł:", content: film.name),
                                if (film.genres.isNotEmpty) Divider(),
                                if (film.genres.isNotEmpty)
                                  DetailsDataRow(
                                    title: "Gatunek:",
                                    widget: Wrap(
                                      children: [
                                        for (int i = 0; i < film.genres.length; i++)
                                          Text("${film.genres[i]}" +
                                              (i < film.genres.length - 1 ? ", " : "")),
                                      ],
                                    ),
                                  ),
                                if (film.details.cast.isNotEmpty) Divider(),
                                if (film.details.cast.isNotEmpty)
                                  DetailsDataRow(title: "Obsada:", content: film.details.cast),
                                if (film.details.director.isNotEmpty) Divider(),
                                if (film.details.director.isNotEmpty)
                                  DetailsDataRow(title: "Reżyser:", content: film.details.director),
                                if (film.details.production.isNotEmpty) Divider(),
                                if (film.details.production.isNotEmpty)
                                  DetailsDataRow(title: "Produkcja:", content: film.details.production),
                                Divider(),
                                DetailsDataRow(
                                  title: "Ocena:",
                                  widget: BlocBuilder<FilmScoresCubit, FilmScoresState>(
                                    builder: (context, state) {
                                      return Wrap(
                                        children: [
                                          Image.asset(
                                            'assets/filmweb-logo.png',
                                            width: 60,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          film.filmWebScore != null
                                              ? Text(
                                                  film.filmWebScore ?? 'no data',
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 3.5,
                                                    vertical: 2,
                                                  ),
                                                  child: Container(
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                Text("${film.details.description}"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else if (state is FilmDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FilmDetailsError) {
                return ErrorColumn(
                  errorMessage: state.message,
                  buttonMessage: 'Odśwież',
                  buttonOnPressed: () {
                    BlocProvider.of<FilmDetailsCubit>(context).getFilmDetails(film);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class DetailsHeaderRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const DetailsHeaderRow({
    @required this.icon,
    @required this.title,
    @required this.content,
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
        SizedBox(
          width: 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title: ",
              style: TextStyle(fontSize: 12),
            ),
            Wrap(
              children: [
                Text(
                  "$content",
                  style: TextStyle(fontSize: 16),
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
  final String content;
  final Widget widget;

  const DetailsDataRow({@required this.title, this.content, this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(title),
        ),
        Expanded(
          child: content != null ? Text(content) : widget,
        )
      ],
    );
  }
}
