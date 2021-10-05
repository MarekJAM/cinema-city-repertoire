import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../data/models/film.dart';

class FilmDetailsScreen extends StatelessWidget {
  final Film film;

  const FilmDetailsScreen({@required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FilmDetailsCubit, FilmDetailsState>(
          builder: (context, state) {
            if (state is FilmDetailsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: Image.network(
                        film.posterLink.replaceAll("md.jpg", "lg.jpg"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DetailsColumnRow(
                                    icon: Icons.calendar_today,
                                    title: "Premiera",
                                    content: film.details.premiereDate,
                                  ),
                                ),
                                Expanded(
                                  child: DetailsColumnRow(
                                    icon: Icons.timer,
                                    title: "Czas trwania",
                                    content: "${film.length} min",
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.orange,),
                            Text("Tytuł: ${film.name}"),
                            Divider(),
                            Text("Gatunek: ${film.genres}"),
                            Divider(),
                            Text("Obsada: ${film.details.cast}"),
                            Divider(),
                            Text("Reżyser: ${film.details.director}"),
                            Divider(),
                            Text("Produkcja: ${film.details.production}"),
                            Divider(),
                            Text("Opis: ${film.details.description}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is FilmDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class DetailsColumnRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const DetailsColumnRow({
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
