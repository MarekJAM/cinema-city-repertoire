import 'package:cinema_city/firebase_options.dart';
import 'package:cinema_city/i18n/strings.g.dart';
import 'package:cinema_city/local_notifications_setup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc/bloc_observer.dart';
import './bloc/blocs.dart';
import 'app.dart';
import 'injection.dart';
import 'hive_registrar.g.dart';

void main() async {
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  Hive.registerAdapters();

  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  if (!kDebugMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  LocaleSettings.useDeviceLocale();

  await LocalNotifications.init();

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
      child: TranslationProvider(child: const App()),
    ),
  );
}
