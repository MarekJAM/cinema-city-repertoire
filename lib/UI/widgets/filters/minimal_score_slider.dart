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
    return OutlinedButton(
      onPressed: () {},
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${t.filters.minimalScore}: ${widget.scoreFilter!.score!.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.filters.noScore,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: widget.scoreFilter!.showFilmsWithNoScore,
                    fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                    onChanged: (val) {
                      setState(() {
                        widget.scoreFilter!.showFilmsWithNoScore = val;
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
                widget.scoreFilter!.score = val;
              });
            },
            max: 10,
          ),
        ],
      ),
    );
  }
}
