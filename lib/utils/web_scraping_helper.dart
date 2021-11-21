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
    var document = parser.parse(responseBody);

    try {
      var results = document.getElementById("searchResult").children[0].children[0].children;

      if (results != null) {
        for (var i = 0; i < results.length; i++) {
          var prodYear = results[i].getElementsByClassName("filmPreview__year")[0].innerHtml;
         
          if (prodYear == film.releaseYear || results.length == 1) {
            var rate = results[i]
                    .getElementsByClassName("filmPreview__rateBox rateBox")[0]
                    ?.attributes['data-rate'] ??
                null;
            return rate.substring(0, 3);
          } 
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
