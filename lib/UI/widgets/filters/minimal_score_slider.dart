import 'package:flutter/material.dart';

class MinimalScoreSlider extends StatefulWidget {
  const MinimalScoreSlider({
    Key key,
  }) : super(key: key);

  @override
  State<MinimalScoreSlider> createState() => _MinimalScoreSliderState();
}

class _MinimalScoreSliderState extends State<MinimalScoreSlider> {
  double _sliderValue = 0;
  bool _checkboxValue = true;

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
                  'Minimalna ocena: ${_sliderValue.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bez oceny',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: _checkboxValue,
                    fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                    onChanged: (_) {
                      setState(() {
                        _checkboxValue = !_checkboxValue;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          Slider(
            value: _sliderValue,
            onChanged: (val) {
              setState(() {
                _sliderValue = val;
              });
            },
            max: 10,
          ),
        ],
      ),
    );
  }
}
