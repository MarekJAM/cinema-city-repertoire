import 'dart:developer';

import '../data/models/models.dart';
import 'package:html/parser.dart' as parser;

class WebScrapperException implements Exception {}

class WebScrapingHelper {
  static FilmDetails scrapFilmDetails(String responseBody) {
    var document = parser.parse(responseBody);

    try {
      var mainTag = document.getElementsByClassName("static-robots-content")[1].text;

      var premiereDateRegExp = RegExp(r'(?<=<span>)(.*)(?=</span>)');
      var pRegExp = RegExp(r'(?<=<p>)(.*)(?=</p>)');

      var premiereDate = premiereDateRegExp.firstMatch(mainTag)!.group(0);
      var description = pRegExp.allMatches(mainTag).elementAt(2).group(0);
      var cast = pRegExp.allMatches(mainTag).elementAt(4).group(0)!.substring(8);
      var director = pRegExp.allMatches(mainTag).elementAt(5).group(0)!.substring(9);
      var production = pRegExp.allMatches(mainTag).elementAt(6).group(0)!.substring(11);

      return FilmDetails(
        premiereDate: premiereDate,
        description: description,
        cast: cast,
        director: director,
        production: production,
      );
    } catch (e) {
      log('$e');
      throw WebScrapperException();
    }
  }

  static String scrapFilmId(Film film, String responseBody) {
    var filmIdRegex = RegExp(r'data-film-id="[0-9]*"');

    var searchedFilmIdsStrings = filmIdRegex.allMatches(responseBody).map((e) => e.group(0)).toList();

    String filmId = '';

    if (searchedFilmIdsStrings.isNotEmpty) {
      filmId = RegExp(r'[0-9]+').stringMatch(searchedFilmIdsStrings[0]!)?.toString() ?? '';
    }

    return filmId;
  }
}
