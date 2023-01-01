import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module  
abstract class RegisterModule {  
  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();  

  Dio get dio => Dio();

  @preResolve
  @Named('filtersBox')
  Future<Box> get filtersBox async => await Hive.openBox<dynamic>('filtersBox');
}