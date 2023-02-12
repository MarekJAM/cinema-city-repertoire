// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cinema_city/app_module.dart' as _i24;
import 'package:cinema_city/bloc/cinemas/cinemas_cubit.dart' as _i22;
import 'package:cinema_city/bloc/dates/dates_cubit.dart' as _i17;
import 'package:cinema_city/bloc/film_details/film_details_cubit.dart' as _i18;
import 'package:cinema_city/bloc/film_scores/film_scores_cubit.dart' as _i19;
import 'package:cinema_city/bloc/filters/filters_cubit.dart' as _i23;
import 'package:cinema_city/bloc/repertoire/repertoire_bloc.dart' as _i21;
import 'package:cinema_city/data/repositories/cinemas_api_client.dart' as _i14;
import 'package:cinema_city/data/repositories/cinemas_local_storage_api.dart'
    as _i15;
import 'package:cinema_city/data/repositories/cinemas_repository.dart' as _i16;
import 'package:cinema_city/data/repositories/film_api_client.dart' as _i5;
import 'package:cinema_city/data/repositories/film_scores_api_client.dart'
    as _i6;
import 'package:cinema_city/data/repositories/film_scores_repository.dart'
    as _i7;
import 'package:cinema_city/data/repositories/filters_repository.dart' as _i20;
import 'package:cinema_city/data/repositories/filters_storage.dart' as _i9;
import 'package:cinema_city/data/repositories/filters_storage_hive.dart'
    as _i10;
import 'package:cinema_city/data/repositories/repertoire_api_client.dart'
    as _i11;
import 'package:cinema_city/data/repositories/repertoire_repository.dart'
    as _i12;
import 'package:cinema_city/data/repositories/repositories.dart' as _i8;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.Box<dynamic>>(
      () => registerModule.filtersBox,
      instanceName: 'filtersBox',
      preResolve: true,
    );
    gh.factory<_i4.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i5.FilmApiClient>(
        () => _i5.FilmApiClient(client: gh<_i4.Dio>()));
    gh.lazySingleton<_i6.FilmScoresApiClient>(
        () => _i6.FilmScoresApiClient(client: gh<_i4.Dio>()));
    gh.lazySingleton<_i7.FilmScoresRepository>(() => _i7.FilmScoresRepository(
        filmScoresApiClient: gh<_i8.FilmScoresApiClient>()));
    gh.factory<_i9.FiltersStorage>(() => _i10.FiltersStorageHive(
        gh<_i3.Box<dynamic>>(instanceName: 'filtersBox')));
    gh.lazySingleton<_i11.RepertoireApiClient>(
        () => _i11.RepertoireApiClient(client: gh<_i4.Dio>()));
    gh.lazySingleton<_i12.RepertoireRepository>(() => _i12.RepertoireRepository(
          repertoireApiClient: gh<_i8.RepertoireApiClient>(),
          filmApiClient: gh<_i8.FilmApiClient>(),
        ));
    await gh.factoryAsync<_i13.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i14.CinemasApiClient>(
        () => _i14.CinemasApiClient(client: gh<_i4.Dio>()));
    gh.lazySingleton<_i15.CinemasLocalStorageApi>(() =>
        _i15.CinemasLocalStorageApi(plugin: gh<_i13.SharedPreferences>()));
    gh.lazySingleton<_i16.CinemasRepository>(() => _i16.CinemasRepository(
          cinemasApiClient: gh<_i8.CinemasApiClient>(),
          cinemasLocalStorageApi: gh<_i15.CinemasLocalStorageApi>(),
        ));
    gh.factory<_i17.DatesCubit>(
        () => _i17.DatesCubit(gh<_i12.RepertoireRepository>()));
    gh.factory<_i18.FilmDetailsCubit>(() => _i18.FilmDetailsCubit(
        repertoireRepository: gh<_i8.RepertoireRepository>()));
    gh.factory<_i19.FilmScoresCubit>(() => _i19.FilmScoresCubit(
        filmScoresRepository: gh<_i8.FilmScoresRepository>()));
    gh.lazySingleton<_i20.FiltersRepository>(
        () => _i20.FiltersRepository(gh<_i8.FiltersStorage>()));
    gh.factory<_i21.RepertoireBloc>(() => _i21.RepertoireBloc(
          repertoireRepository: gh<_i8.RepertoireRepository>(),
          filtersRepository: gh<_i8.FiltersRepository>(),
          filmScoresRepository: gh<_i8.FilmScoresRepository>(),
        ));
    gh.factory<_i22.CinemasCubit>(() =>
        _i22.CinemasCubit(cinemasRepository: gh<_i8.CinemasRepository>()));
    gh.factory<_i23.FiltersCubit>(() =>
        _i23.FiltersCubit(gh<_i8.FiltersRepository>())
          ..loadFiltersOnAppStarted());
    return this;
  }
}

class _$RegisterModule extends _i24.RegisterModule {}
