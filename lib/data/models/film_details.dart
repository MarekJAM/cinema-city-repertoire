class FilmDetails {
  final String? description;
  final String? premiereDate;
  final String cast;
  final String director;
  final String production;

  FilmDetails({
    required this.description,
    required this.premiereDate,
    required this.cast,
    required this.director,
    required this.production,
  });

  static FilmDetails get mock => FilmDetails(
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua" * 4,
        premiereDate: "premiereDate",
        cast: "cast member1, cast member2, cast member3, cast member4",
        director: "director name",
        production: "production",
      );
}