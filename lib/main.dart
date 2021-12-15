import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

import './bloc/simple_bloc_delegate.dart';
import './bloc/blocs.dart';
import './data/repositories/repositories.dart';
import './UI/screens/repertoire_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      tz.initializeTimeZones();

      final CinemasRepository cinemasRepository = CinemasRepository(
        cinemasApiClient: CinemasApiClient(
          httpClient: http.Client(),
        ),
      );

      final RepertoireRepository repertoireRepository = RepertoireRepository(
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

      final FilmScoresRepository filmScoresRepository = FilmScoresRepository(
        filmScoresApiClient: FilmScoresApiClient(
          httpClient: http.Client(),
        ),
      );

      WidgetsFlutterBinding.ensureInitialized();

      final repertoireBloc = RepertoireBloc(
        repertoireRepository: repertoireRepository,
      );

      final filmScoresCubit =
          FilmScoresCubit(repertoireBloc: repertoireBloc, filmScoresRepository: filmScoresRepository);

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
              create: (context) => FilmDetailsCubit(repertoireRepository: repertoireRepository),
            ),
            BlocProvider<FilmScoresCubit>(
              create: (context) => filmScoresCubit,
            )
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
