import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc/bloc_observer.dart';
import './bloc/blocs.dart';
import './data/models/filters/filters.dart';
import 'app.dart';
import 'injection.dart';

void main() async {
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  Hive.registerAdapter(GenreFilterAdapter());
  Hive.registerAdapter(EventTypeFilterAdapter());
  Hive.registerAdapter(ScoreFilterAdapter());

  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CinemasCubit>(
          create: (context) => di()..getCinemas(),
        ),
        BlocProvider<RepertoireBloc>(
          create: (context) => di(),
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
          create: (context) => di(),
        ),
      ],
      child: const App(),
    ),
  );
}
