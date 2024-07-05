// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cinema_city_interceptors.dart';
import 'filmweb_interceptors.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();

  @Named('dioCinemaCity')
  @lazySingleton
  Dio get dioCinemaCity => Dio(
        BaseOptions(
          baseUrl: 'https://www.cinema-city.pl/pl/data-api-service/v1/quickbook/10103',
        ),
      )..interceptors.addAll(cinemaCityInterceptors);

  @Named('dioCinemaCityTickets')
  @lazySingleton
  Dio get dioCinemaCityTickets => Dio(
        BaseOptions(
          baseUrl: 'https://tickets.cinema-city.pl/api/',
        ),
      );

  @Named('dioFilmweb')
  @lazySingleton
  Dio get dioFilmweb => Dio(
        BaseOptions(
          baseUrl: 'https://www.filmweb.pl/api/v1',
        ),
      )..interceptors.addAll(filmwebInterceptors);

  @preResolve
  @Named('filtersBox')
  Future<Box> get filtersBox async => await Hive.openBox<dynamic>('filtersBox');

  FlutterLocalNotificationsPlugin get localNotifications => FlutterLocalNotificationsPlugin();
}
