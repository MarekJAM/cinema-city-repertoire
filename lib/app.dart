import 'package:cinema_city/i18n/strings.g.dart';
import 'package:cinema_city/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart' hide GlobalMaterialLocalizations;
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
        Locale('pl'),
      ],
      title: t.appName,
      theme: theme,
      builder: (context, child) => SkeletonizerConfig(
        data: SkeletonizerConfigData(brightness: Theme.of(context).brightness),
        child: child!,
      ),
      home: const RepertoirePage(),
    );
  }
}
