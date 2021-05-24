import 'exceptions.dart';

class ApiClient {
  static const baseUrl = 'https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103';

  void throwException(int statusCode, String message) {
    if (statusCode > 400 && 500 > statusCode) {
      throw ClientException('$message, status code: $statusCode');
    } else if (statusCode > 500) {
      throw ServerException('$message, status code: $statusCode');
    } else {
      throw Exception('$message, status code: $statusCode');
    }
  }
}
