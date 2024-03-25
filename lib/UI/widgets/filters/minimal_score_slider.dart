import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../data/models/filters/score_filter.dart';
import '../../../i18n/strings.g.dart';

class MinimalScoreSlider extends StatefulWidget {
  final ScoreFilter? scoreFilter;

  const MinimalScoreSlider({
    Key? key,
    this.scoreFilter,
  }) : super(key: key);

  @override
  State<MinimalScoreSlider> createState() => _MinimalScoreSliderState();
}

class _MinimalScoreSliderState extends State<MinimalScoreSlider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${t.filters.minimalRating}: ${widget.scoreFilter!.score!.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.filters.noRating,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Checkbox(
                      value: widget.scoreFilter?.showFilmsWithNoScore,
                      fillColor: MaterialStateProperty.all(context.colorScheme.primary),
                      checkColor: context.colorScheme.background,
                      onChanged: (val) {
                        setState(() {
                          widget.scoreFilter?.showFilmsWithNoScore = val;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
            Slider(
              value: widget.scoreFilter!.score!,
              onChanged: (val) {
                setState(() {
                  widget.scoreFilter?.score = val;
                });
              },
              max: 10,
            ),
          ],
        ),
      ),
    );
  }
}
