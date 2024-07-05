// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cinema_city/app_module.dart' as _i27;
import 'package:cinema_city/bloc/cinemas/cinemas_cubit.dart' as _i23;
import 'package:cinema_city/bloc/dates/dates_cubit.dart' as _i24;
import 'package:cinema_city/bloc/film_details/film_details_cubit.dart' as _i25;
import 'package:cinema_city/bloc/film_scores/film_scores_cubit.dart' as _i20;
import 'package:cinema_city/bloc/filters/filters_cubit.dart' as _i21;
import 'package:cinema_city/bloc/repertoire/repertoire_bloc.dart' as _i26;
import 'package:cinema_city/data/repositories/cinemas_api_client.dart' as _i13;
import 'package:cinema_city/data/repositories/cinemas_local_storage_api.dart'
    as _i12;
import 'package:cinema_city/data/repositories/cinemas_repository.dart' as _i18;
import 'package:cinema_city/data/repositories/film_api_client.dart' as _i14;
import 'package:cinema_city/data/repositories/film_scores_api_client.dart'
    as _i8;
import 'package:cinema_city/data/repositories/film_scores_repository.dart'
    as _i19;
import 'package:cinema_city/data/repositories/filters_repository.dart' as _i16;
import 'package:cinema_city/data/repositories/filters_storage.dart' as _i9;
import 'package:cinema_city/data/repositories/filters_storage_hive.dart'
    as _i10;
import 'package:cinema_city/data/repositories/repertoire_api_client.dart'
    as _i15;
import 'package:cinema_city/data/repositories/repertoire_repository.dart'
    as _i22;
import 'package:cinema_city/data/repositories/repositories.dart' as _i17;
import 'package:cinema_city/data/repositories/seatplan_api_client.dart' as _i7;
import 'package:cinema_city/data/repositories/seatplan_repository.dart' as _i11;
import 'package:dio/dio.dart' as _i5;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
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
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.FlutterLocalNotificationsPlugin>(
        () => registerModule.localNotifications);
    gh.lazySingleton<_i5.Dio>(
      () => registerModule.dioCinemaCity,
      instanceName: 'dioCinemaCity',
    );
    await gh.factoryAsync<_i6.Box<dynamic>>(
      () => registerModule.filtersBox,
      instanceName: 'filtersBox',
      preResolve: true,
    );
    gh.lazySingleton<_i5.Dio>(
      () => registerModule.dioCinemaCityTickets,
      instanceName: 'dioCinemaCityTickets',
    );
    gh.lazySingleton<_i5.Dio>(
      () => registerModule.dioFilmweb,
      instanceName: 'dioFilmweb',
    );
    gh.lazySingleton<_i7.SeatplanApiClient>(() => _i7.SeatplanApiClient(
        client: gh<_i5.Dio>(instanceName: 'dioCinemaCityTickets')));
    gh.lazySingleton<_i8.FilmScoresApiClient>(() => _i8.FilmScoresApiClient(
        client: gh<_i5.Dio>(instanceName: 'dioFilmweb')));
    gh.factory<_i9.FiltersStorage>(() => _i10.FiltersStorageHive(
        gh<_i6.Box<dynamic>>(instanceName: 'filtersBox')));
    gh.lazySingleton<_i11.SeatplanRepository>(
        () => _i11.SeatplanRepository(apiClient: gh<_i7.SeatplanApiClient>()));
    gh.lazySingleton<_i12.CinemasLocalStorageApi>(
        () => _i12.CinemasLocalStorageApi(plugin: gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i13.CinemasApiClient>(() => _i13.CinemasApiClient(
        client: gh<_i5.Dio>(instanceName: 'dioCinemaCity')));
    gh.lazySingleton<_i14.FilmApiClient>(() =>
        _i14.FilmApiClient(client: gh<_i5.Dio>(instanceName: 'dioCinemaCity')));
    gh.lazySingleton<_i15.RepertoireApiClient>(() => _i15.RepertoireApiClient(
        client: gh<_i5.Dio>(instanceName: 'dioCinemaCity')));
    gh.lazySingleton<_i16.FiltersRepository>(
        () => _i16.FiltersRepository(gh<_i17.FiltersStorage>()));
    gh.lazySingleton<_i18.CinemasRepository>(() => _i18.CinemasRepository(
          cinemasApiClient: gh<_i17.CinemasApiClient>(),
          cinemasLocalStorageApi: gh<_i12.CinemasLocalStorageApi>(),
        ));
    gh.lazySingleton<_i19.FilmScoresRepository>(() => _i19.FilmScoresRepository(
        filmScoresApiClient: gh<_i17.FilmScoresApiClient>()));
    gh.factory<_i20.FilmScoresCubit>(() => _i20.FilmScoresCubit(
        filmScoresRepository: gh<_i17.FilmScoresRepository>()));
    gh.factory<_i21.FiltersCubit>(() =>
        _i21.FiltersCubit(gh<_i17.FiltersRepository>())
          ..loadFiltersOnAppStarted());
    gh.lazySingleton<_i22.RepertoireRepository>(() => _i22.RepertoireRepository(
          repertoireApiClient: gh<_i17.RepertoireApiClient>(),
          filmApiClient: gh<_i17.FilmApiClient>(),
        ));
    gh.factory<_i23.CinemasCubit>(() =>
        _i23.CinemasCubit(cinemasRepository: gh<_i17.CinemasRepository>()));
    gh.factory<_i24.DatesCubit>(
        () => _i24.DatesCubit(gh<_i22.RepertoireRepository>()));
    gh.factory<_i25.FilmDetailsCubit>(() => _i25.FilmDetailsCubit(
        repertoireRepository: gh<_i17.RepertoireRepository>()));
    gh.factory<_i26.RepertoireBloc>(() => _i26.RepertoireBloc(
          repertoireRepository: gh<_i17.RepertoireRepository>(),
          filtersRepository: gh<_i17.FiltersRepository>(),
          filmScoresRepository: gh<_i17.FilmScoresRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i27.RegisterModule {}
