// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cinema_city/app_module.dart' as _i645;
import 'package:cinema_city/bloc/cinemas/cinemas_cubit.dart' as _i171;
import 'package:cinema_city/bloc/dates/dates_cubit.dart' as _i176;
import 'package:cinema_city/bloc/film_details/film_details_cubit.dart' as _i449;
import 'package:cinema_city/bloc/film_scores/film_scores_cubit.dart' as _i219;
import 'package:cinema_city/bloc/filters/filters_cubit.dart' as _i49;
import 'package:cinema_city/bloc/repertoire/repertoire_bloc.dart' as _i914;
import 'package:cinema_city/data/repositories/cinemas_api_client.dart' as _i461;
import 'package:cinema_city/data/repositories/cinemas_local_storage_api.dart'
    as _i347;
import 'package:cinema_city/data/repositories/cinemas_repository.dart' as _i610;
import 'package:cinema_city/data/repositories/film_api_client.dart' as _i826;
import 'package:cinema_city/data/repositories/film_scores_api_client.dart'
    as _i622;
import 'package:cinema_city/data/repositories/film_scores_repository.dart'
    as _i640;
import 'package:cinema_city/data/repositories/filters_repository.dart' as _i263;
import 'package:cinema_city/data/repositories/filters_storage.dart' as _i833;
import 'package:cinema_city/data/repositories/filters_storage_hive.dart'
    as _i347;
import 'package:cinema_city/data/repositories/repertoire_api_client.dart'
    as _i695;
import 'package:cinema_city/data/repositories/repertoire_repository.dart'
    as _i80;
import 'package:cinema_city/data/repositories/repositories.dart' as _i400;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i163.FlutterLocalNotificationsPlugin>(
        () => registerModule.localNotifications);
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dioCinemaCity,
      instanceName: 'dioCinemaCity',
    );
    await gh.factoryAsync<_i738.Box<dynamic>>(
      () => registerModule.filtersBox,
      instanceName: 'filtersBox',
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dioFilmweb,
      instanceName: 'dioFilmweb',
    );
    gh.lazySingleton<_i622.FilmScoresApiClient>(() => _i622.FilmScoresApiClient(
        client: gh<_i361.Dio>(instanceName: 'dioFilmweb')));
    gh.lazySingleton<_i347.CinemasLocalStorageApi>(() =>
        _i347.CinemasLocalStorageApi(plugin: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i461.CinemasApiClient>(() => _i461.CinemasApiClient(
        client: gh<_i361.Dio>(instanceName: 'dioCinemaCity')));
    gh.lazySingleton<_i826.FilmApiClient>(() => _i826.FilmApiClient(
        client: gh<_i361.Dio>(instanceName: 'dioCinemaCity')));
    gh.lazySingleton<_i695.RepertoireApiClient>(() => _i695.RepertoireApiClient(
        client: gh<_i361.Dio>(instanceName: 'dioCinemaCity')));
    gh.factory<_i833.FiltersStorage>(() => _i347.FiltersStorageHive(
        gh<_i738.Box<dynamic>>(instanceName: 'filtersBox')));
    gh.lazySingleton<_i263.FiltersRepository>(
        () => _i263.FiltersRepository(gh<_i400.FiltersStorage>()));
    gh.lazySingleton<_i610.CinemasRepository>(() => _i610.CinemasRepository(
          cinemasApiClient: gh<_i400.CinemasApiClient>(),
          cinemasLocalStorageApi: gh<_i347.CinemasLocalStorageApi>(),
        ));
    gh.lazySingleton<_i640.FilmScoresRepository>(() =>
        _i640.FilmScoresRepository(
            filmScoresApiClient: gh<_i400.FilmScoresApiClient>()));
    gh.factory<_i219.FilmScoresCubit>(() => _i219.FilmScoresCubit(
        filmScoresRepository: gh<_i400.FilmScoresRepository>()));
    gh.factory<_i49.FiltersCubit>(() =>
        _i49.FiltersCubit(gh<_i400.FiltersRepository>())
          ..loadFiltersOnAppStarted());
    gh.lazySingleton<_i80.RepertoireRepository>(() => _i80.RepertoireRepository(
          repertoireApiClient: gh<_i400.RepertoireApiClient>(),
          filmApiClient: gh<_i400.FilmApiClient>(),
        ));
    gh.factory<_i171.CinemasCubit>(() =>
        _i171.CinemasCubit(cinemasRepository: gh<_i400.CinemasRepository>()));
    gh.factory<_i176.DatesCubit>(
        () => _i176.DatesCubit(gh<_i80.RepertoireRepository>()));
    gh.factory<_i449.FilmDetailsCubit>(() => _i449.FilmDetailsCubit(
        repertoireRepository: gh<_i400.RepertoireRepository>()));
    gh.factory<_i914.RepertoireBloc>(() => _i914.RepertoireBloc(
          repertoireRepository: gh<_i400.RepertoireRepository>(),
          filtersRepository: gh<_i400.FiltersRepository>(),
          filmScoresRepository: gh<_i400.FilmScoresRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i645.RegisterModule {}
