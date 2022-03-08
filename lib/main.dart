import 'package:cinema_city/data/models/filters/filters.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

import './bloc/simple_bloc_delegate.dart';
import './bloc/blocs.dart';
import './data/repositories/repositories.dart';
import './UI/screens/repertoire_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      await Hive.initFlutter();

      Hive.registerAdapter(GenreFilterAdapter());
      Hive.registerAdapter(EventTypeFilterAdapter());

      final filtersBox =
          await Hive.openBox<dynamic>('filtersBox');

      tz.initializeTimeZones();

      final cinemasRepository = CinemasRepository(
        cinemasApiClient: CinemasApiClient(
          httpClient: http.Client(),
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

      final filtersRepository =
          FiltersRepository(FiltersStorageHive(filtersBox));

      WidgetsFlutterBinding.ensureInitialized();

      final repertoireBloc = RepertoireBloc(
        repertoireRepository: repertoireRepository,
      );

      final filmScoresCubit = FilmScoresCubit(
        repertoireBloc: repertoireBloc,
        filmScoresRepository: filmScoresRepository,
      );

      final filtersCubit = FiltersCubit(filtersRepository)..loadFiltersOnAppStarted();

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<CinemasBloc>(
              create: (context) => CinemasBloc(
                cinemasRepository: cinemasRepository,
              )..add(GetCinemas()),
            ),
            BlocProvider<RepertoireBloc>(
              create: (context) => repertoireBloc,
            ),
            BlocProvider<DatesCubit>(
              create: (context) => DatesCubit(repertoireRepository),
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
          child: App(),
        ),
      );
    },
    blocObserver: kDebugMode ? SimpleBlocObserver() : null,
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final ThemeData theme = ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.grey[900],
      primarySwatch: Colors.orange,
      brightness: Brightness.dark,
      indicatorColor: Colors.orange,
    );

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pl'),
      ],
      title: 'Cinema City Repertuar',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.orange),
      ),
      home: RepertoireScreen(),
    );
  }
}
