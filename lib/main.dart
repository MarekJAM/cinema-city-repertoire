import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import './bloc/simple_bloc_delegate.dart';
import './bloc/blocs.dart';
import './data/repositories/repositories.dart';
import './data/models/filters/filters.dart';
import 'app.dart';
import 'data/repositories/cinemas_local_storage_api.dart';

void main() async {
  if (kDebugMode) Bloc.observer = SimpleBlocObserver();

  await Hive.initFlutter();

  Hive.registerAdapter(GenreFilterAdapter());
  Hive.registerAdapter(EventTypeFilterAdapter());
  Hive.registerAdapter(ScoreFilterAdapter());

  final filtersBox = await Hive.openBox<dynamic>('filtersBox');

  tz.initializeTimeZones();

  final cinemasRepository = CinemasRepository(
    cinemasApiClient: CinemasApiClient(
      httpClient: http.Client(),
    ),
    cinemasLocalStorageApi: CinemasLocalStorageApi(
      plugin: await SharedPreferences.getInstance(),
    ),
  );

  final repertoireRepository = RepertoireRepository(
    repertoireApiClient: RepertoireApiClient(
      httpClient: http.Client(),
    ),
    filmApiClient: FilmApiClient(
      httpClient: http.Client(),
    ),
    filmScoresApiClient: FilmScoresApiClient(
      httpClient: http.Client(),
    ),
  );

  final filmScoresRepository = FilmScoresRepository(
    filmScoresApiClient: FilmScoresApiClient(
      httpClient: http.Client(),
    ),
  );

  final filtersRepository = FiltersRepository(FiltersStorageHive(filtersBox));

  WidgetsFlutterBinding.ensureInitialized();

  final filtersCubit = FiltersCubit(filtersRepository)..loadFiltersOnAppStarted();

  final cinemasCubit = CinemasCubit(
    cinemasRepository: cinemasRepository,
  )..getCinemas();

  final filmScoresCubit = FilmScoresCubit(
    filmScoresRepository: filmScoresRepository,
  );

  final repertoireBloc = RepertoireBloc(
    repertoireRepository: repertoireRepository,
    filtersCubit: filtersCubit,
    filtersRepository: filtersRepository,
    filmScoresRepository: filmScoresRepository,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CinemasCubit>(
          create: (context) => cinemasCubit,
        ),
        BlocProvider<RepertoireBloc>(
          create: (context) => repertoireBloc,
        ),
        BlocProvider<DatesCubit>(
          create: (context) => DatesCubit(
            repertoireRepository,
          ),
        ),
        BlocProvider<CinemasCubit>(
          create: (context) => cinemasCubit,
        ),
        BlocProvider<FilmDetailsCubit>(
          create: (context) => FilmDetailsCubit(
            repertoireRepository: repertoireRepository,
          ),
        ),
        BlocProvider<FilmScoresCubit>(
          create: (context) => filmScoresCubit,
        ),
        BlocProvider<FiltersCubit>(
          create: (context) => filtersCubit,
        ),
      ],
      child: const App(),
    ),
  );
}