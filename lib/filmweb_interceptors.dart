import 'package:dio/dio.dart';

final filmwebInterceptors = [_LocaleInterceptor()];

class _LocaleInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addEntries([const MapEntry('X-Locale', "pl")]);
    super.onRequest(options, handler);
  }
}
