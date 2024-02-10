import 'dart:developer';

import '../data/models/models.dart';
import 'package:html/parser.dart' as parser;
import '../utils/string_extensions.dart';

class WebScrapperException implements Exception {}

class WebScrapingHelper {
  static FilmDetails scrapFilmDetails(String responseBody) {
    var document = parser.parse(responseBody);

    try {
      var mainTag = document.getElementsByClassName("static-robots-content")[1].text;

      var premiereDateRegExp = RegExp(r'(?<=<span>)(.*)(?=</span>)');
      var pRegExp = RegExp(r'(?<=<p>)(.*)(?=</p>)');

      var premiereDate = premiereDateRegExp.firstMatch(mainTag)?.group(0);
      var description = pRegExp.allMatches(mainTag).elementAt(2).group(0);
      var cast = pRegExp.allMatches(mainTag).elementAt(4).group(0)?.removeFirstWord() ?? '';
      var director = pRegExp.allMatches(mainTag).elementAt(5).group(0)?.removeFirstWord() ?? '';
      var production = pRegExp.allMatches(mainTag).elementAt(6).group(0)?.removeFirstWord() ?? '';

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
}
