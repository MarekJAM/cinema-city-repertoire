import 'package:cinema_city/i18n/strings.g.dart';
import 'package:dio/dio.dart';

final cinemaCityInterceptors = [_LocaleInterceptor()];

class _LocaleInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLocale appLocale = t.$meta.locale;
    final locale = appLocale.languageCode == 'en' ? 'en_GB' : 'pl_PL';
    options.queryParameters.addEntries([MapEntry('lang', locale)]);
    super.onRequest(options, handler);
  }
}

