import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module  
abstract class RegisterModule {  
  @preResolve
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();  

  Dio get dio => Dio();
}