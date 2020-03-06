import 'package:cinema_city/Providers/cinemas.dart';
import 'package:cinema_city/Screens/repertoire_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Providers/repertoire.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          primarySwatch: Colors.orange,
          brightness: Brightness.dark
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: RepertoireScreen(),
      ),
    );
  }
}
