import 'package:cinema_city/UI/widgets/cinemas_list.dart';
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
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: 1,
          useSafeArea: true,
          builder: (context) => const CinemasList(),
        );
      },
    );
  }
}
