import './api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CinemasApiClient extends ApiClient {
  final _cinemaseEndpoint =
      '/pl/data-api-service/v1/quickbook/10103/film-events/in-cinema/';

  final http.Client httpClient;

  CinemasApiClient({this.httpClient}) : assert(httpClient != null);

  Future<List<dynamic>> fetchData(String date, [List<String> cinemaIds]) async {
    List<http.Response> responseList =
        await Future.wait(cinemaIds.map((cinemaId) => httpClient.get(
              '${ApiClient.baseUrl}$_cinemaseEndpoint$cinemaId/at-date/$date?attr=&lang=pl_PL',
            )));

    responseList.forEach(
      (response) {
        if (response.statusCode != 200) {
          throwException(response.statusCode, 'Error getting cinemas');
        }
      },
    );

    List<dynamic> extFilms = [];
    List<dynamic> extEvents = [];

    for(var response in responseList){
        var extResponse = json.decode(response.body);
        extFilms.addAll(extResponse['body']['films']);
        extEvents.addAll(extResponse['body']['events']);
      }
      

    final List<dynamic> returnedData = [];
    // List<dynamic> responseData = jsonParse(response);
    // responseData.forEach((section) {
    //   returnedData.add(OfficeInfoSection.fromJson(section));
    // });
    return returnedData;
  }
}
