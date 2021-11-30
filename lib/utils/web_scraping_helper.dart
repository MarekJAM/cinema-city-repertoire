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
    var scoreRegex = new RegExp(r'data-rate="+[0-9]+\.+[0-9]{15,20}');
    var releaseRegex = new RegExp(r'data-release="+[0-9]+[0-9]+[0-9]+[0-9]');
  
    var scores = scoreRegex.allMatches(responseBody).map((e) => responseBody.substring(e.start + 11, e.start + 14)).toList();
    var releaseYears = releaseRegex.allMatches(responseBody).map((e) => responseBody.substring(e.start + 14, e.start + 18)).toList();

    if (scores.length == 1) {
      return scores[0];
    }

    for (int i = 0; i < scores.length; i ++) {
      if (releaseYears[i] == film.releaseYear) {
        return scores[i];
      }
    }

    return null;
  }
}
