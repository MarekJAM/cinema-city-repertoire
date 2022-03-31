import '../data/models/models.dart';
import 'package:html/parser.dart' as parser;

class WebScrapingHelper {
  static FilmDetails scrapFilmDetails(String responseBody) {
    var document = parser.parse(responseBody);

    try {
      var mainTag = document.getElementsByClassName("static-robots-content")[1].text;

      var premiereDateRegExp = RegExp(r'(?<=<span>)(.*)(?=</span>)');
      var pRegExp = RegExp(r'(?<=<p>)(.*)(?=</p>)');

      var premiereDate = premiereDateRegExp.firstMatch(mainTag).group(0);
      var description = pRegExp.allMatches(mainTag).elementAt(2).group(0);
      var cast = pRegExp.allMatches(mainTag).elementAt(4).group(0).substring(8);
      var director = pRegExp.allMatches(mainTag).elementAt(5).group(0).substring(9);
      var production = pRegExp.allMatches(mainTag).elementAt(6).group(0).substring(11);

      return FilmDetails(
        premiereDate: premiereDate,
        description: description,
        cast: cast,
        director: director,
        production: production,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String scrapFilmWebScore(Film film, String responseBody) {
    var filmRegex = new RegExp('(?<=${film.name}).*?(> <div class=\"content__sidebar\">)');

    var scoreRegex = new RegExp(r'ratingValue">+[0-9]+\,+[0-9]');

    var searchedFilmsStrings = filmRegex.allMatches(responseBody).map((e) => e.group(0)).toList();

    String score;
    String retScore;

    if (searchedFilmsStrings != null && searchedFilmsStrings.length > 0) {
      score = scoreRegex.stringMatch(searchedFilmsStrings[0])?.substring(13, 16);
      retScore = score.replaceFirst(RegExp(r','), '.');
    }

    return retScore;
  }
}
