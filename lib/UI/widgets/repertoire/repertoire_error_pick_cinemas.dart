import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../error_column.dart';

class RepertoireErrorPickCinemas extends StatelessWidget {
  const RepertoireErrorPickCinemas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorColumn(
        errorMessage: t.repertoire.noFilmsToDisplay,
        buttonMessage: t.repertoire.pickCinemas,
        buttonOnPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
      );
  }
}
