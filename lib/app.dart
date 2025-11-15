import 'package:cinema_city/i18n/strings.g.dart';
import 'package:cinema_city/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/pages/repertoire_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      .portraitUp,
      .portraitDown,
    ]);

    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
        Locale('pl'),
      ],
      title: t.appName,
      theme: theme,
      home: const RepertoirePage(),
    );
  }
}
