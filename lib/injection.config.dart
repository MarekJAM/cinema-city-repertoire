// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cinema_city/app_module.dart' as _i22;
import 'package:cinema_city/bloc/cinemas/cinemas_cubit.dart' as _i21;
import 'package:cinema_city/bloc/dates/dates_cubit.dart' as _i17;
import 'package:cinema_city/bloc/film_details/film_details_cubit.dart' as _i18;
import 'package:cinema_city/bloc/film_scores/film_scores_cubit.dart' as _i19;
import 'package:cinema_city/data/repositories/cinemas_api_client.dart' as _i14;
import 'package:cinema_city/data/repositories/cinemas_local_storage_api.dart'
    as _i15;
import 'package:cinema_city/data/repositories/cinemas_repository.dart' as _i16;
import 'package:cinema_city/data/repositories/film_api_client.dart' as _i4;
import 'package:cinema_city/data/repositories/film_scores_api_client.dart'
    as _i5;
import 'package:cinema_city/data/repositories/film_scores_repository.dart'
    as _i6;
import 'package:cinema_city/data/repositories/filters_repository.dart' as _i20;
import 'package:cinema_city/data/repositories/filters_storage.dart' as _i8;
import 'package:cinema_city/data/repositories/filters_storage_hive.dart' as _i9;
import 'package:cinema_city/data/repositories/repertoire_api_client.dart'
    as _i11;
import 'package:cinema_city/data/repositories/repertoire_repository.dart'
    as _i12;
import 'package:cinema_city/data/repositories/repositories.dart' as _i7;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i4.FilmApiClient>(
        () => _i4.FilmApiClient(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i5.FilmScoresApiClient>(
        () => _i5.FilmScoresApiClient(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i6.FilmScoresRepository>(() => _i6.FilmScoresRepository(
        filmScoresApiClient: gh<_i7.FilmScoresApiClient>()));
    gh.lazySingleton<_i8.FiltersStorage>(
        () => _i9.FiltersStorageHive(gh<_i10.Box<dynamic>>()));
    gh.lazySingleton<_i11.RepertoireApiClient>(
        () => _i11.RepertoireApiClient(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i12.RepertoireRepository>(() => _i12.RepertoireRepository(
        repertoireApiClient: gh<_i7.RepertoireApiClient>(),
        filmApiClient: gh<_i7.FilmApiClient>()));
    await gh.factoryAsync<_i13.SharedPreferences>(() => registerModule.prefs,
        preResolve: true);
    gh.lazySingleton<_i14.CinemasApiClient>(
        () => _i14.CinemasApiClient(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i15.CinemasLocalStorageApi>(() =>
        _i15.CinemasLocalStorageApi(plugin: gh<_i13.SharedPreferences>()));
    gh.lazySingleton<_i16.CinemasRepository>(() => _i16.CinemasRepository(
        cinemasApiClient: gh<_i7.CinemasApiClient>(),
        cinemasLocalStorageApi: gh<_i15.CinemasLocalStorageApi>()));
    gh.factory<_i17.DatesCubit>(
        () => _i17.DatesCubit(gh<_i12.RepertoireRepository>()));
    gh.factory<_i18.FilmDetailsCubit>(() => _i18.FilmDetailsCubit(
        repertoireRepository: gh<_i7.RepertoireRepository>()));
    gh.factory<_i19.FilmScoresCubit>(() => _i19.FilmScoresCubit(
        filmScoresRepository: gh<_i7.FilmScoresRepository>()));
    gh.lazySingleton<_i20.FiltersRepository>(
        () => _i20.FiltersRepository(gh<_i7.FiltersStorage>()));
    gh.factory<_i21.CinemasCubit>(() =>
        _i21.CinemasCubit(cinemasRepository: gh<_i7.CinemasRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i22.RegisterModule {}
