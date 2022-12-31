import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc/bloc_observer.dart';
import './bloc/blocs.dart';
import './data/repositories/repositories.dart';
import './data/models/filters/filters.dart';
import 'app.dart';
import 'injection.dart';

void main() async {
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  Hive.registerAdapter(GenreFilterAdapter());
  Hive.registerAdapter(EventTypeFilterAdapter());
  Hive.registerAdapter(ScoreFilterAdapter());

  final filtersBox = await Hive.openBox<dynamic>('filtersBox');

  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final filtersRepository = FiltersRepository(FiltersStorageHive(filtersBox));

  final filtersCubit = FiltersCubit(filtersRepository)..loadFiltersOnAppStarted();

  final repertoireBloc = RepertoireBloc(
    repertoireRepository: di(),
    filtersRepository: filtersRepository,
    filmScoresRepository: di(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CinemasCubit>(
          create: (context) => di()..getCinemas(),
        ),
        BlocProvider<RepertoireBloc>(
          create: (context) => repertoireBloc,
        ),
        BlocProvider<DatesCubit>(
          create: (context) => di(),
        ),
        BlocProvider<FilmDetailsCubit>(
          create: (context) => di(),
        ),
        BlocProvider<FilmScoresCubit>(
          create: (context) => di(),
        ),
        BlocProvider<FiltersCubit>(
          create: (context) => filtersCubit,
        ),
      ],
      child: const App(),
    ),
  );
}
