import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/pages/repertoire_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final ThemeData theme = ThemeData(
      primaryColor: Colors.black,
      indicatorColor: Colors.orange,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ).copyWith(
        background: Colors.grey[900],
      ),
    );

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl'),
      ],
      title: 'Cinema City Repertuar',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.orange),
      ),
      home: const RepertoirePage(),
    );
  }
}
