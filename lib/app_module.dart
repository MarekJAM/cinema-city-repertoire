import 'package:cinema_city/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();

  @Named('dioCinemaCity')
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: 'https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103',
        ),
      )..interceptors.add(LanguageInterceptor());

  @Named('dioFilmweb')
  @lazySingleton
  Dio get dio2 => Dio(BaseOptions(baseUrl: 'https://www.filmweb.pl/api/v1'));

  @preResolve
  @Named('filtersBox')
  Future<Box> get filtersBox async => await Hive.openBox<dynamic>('filtersBox');

  FlutterLocalNotificationsPlugin get localNotifications => FlutterLocalNotificationsPlugin();
}
