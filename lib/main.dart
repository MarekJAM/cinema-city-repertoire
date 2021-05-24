import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';

import './bloc/simple_bloc_delegate.dart';
import './bloc/blocs.dart';
import './data/repositories/repositories.dart';
import './UI/screens/repertoire_screen.dart';

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
        BlocProvider<DatesCubit>(
          create: (context) => DatesCubit(repertoireRepository),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    BlocProvider.of<CinemasBloc>(context).add(FetchCinemas());

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pl'),
      ],
      title: 'Cinema City Repertuar',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
        indicatorColor: Colors.orange,
        accentColor: Colors.orange,
      ),
      home: RepertoireScreen(),
    );
  }
}
