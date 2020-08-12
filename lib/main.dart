import 'package:cinema_city/Providers/cinemas.dart';
import 'package:cinema_city/Screens/repertoire_screen.dart';
import 'package:cinema_city/bloc/repertoire/bloc.dart';
import 'package:cinema_city/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import './bloc/simple_bloc_delegate.dart';
import './bloc/cinemas/bloc.dart';
import './data/repositories/repositories.dart';

import 'Providers/repertoire.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final CinemasRepository cinemasRepository = CinemasRepository(
    cinemasApiClient: CinemasApiClient(
      httpClient: http.Client(),
    ),
  );
  final RepertoireRepository repertoireRepository = RepertoireRepository(
    repertoireApiClient: RepertoireApiClient(
      httpClient: http.Client(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CinemasBloc>(
          create: (context) => CinemasBloc(
            cinemasRepository: cinemasRepository,
          ),
        ),
        BlocProvider<RepertoireBloc>(
          create: (context) => RepertoireBloc(
            repertoireRepository: repertoireRepository,
          ),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CinemasBloc>(context).add(FetchCinemas());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Repertoire(),
        ),
        ChangeNotifierProvider.value(
          value: Cinemas(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('pl'),
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.orange, brightness: Brightness.dark),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: RepertoireScreen(),
      ),
    );
  }
}
