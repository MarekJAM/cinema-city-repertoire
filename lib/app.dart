import 'package:cinema_city/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'UI/pages/repertoire_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  final buttonBorderRadius = 10.0;
  ButtonStyle get commonButtonStyle => ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
        ),
      );

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
        backgroundColor: Colors.grey[900],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: commonButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: commonButtonStyle),
      textButtonTheme: TextButtonThemeData(style: commonButtonStyle),
    );

    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pl'),
      ],
      title: t.appName,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.orange),
      ),
      home: const RepertoirePage(),
    );
  }
}
