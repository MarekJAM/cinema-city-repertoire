import 'package:flutter/material.dart';

class FilterValueButton extends StatefulWidget {
  const FilterValueButton({
    Key key,
    @required this.value,
    @required this.pickedValues,
    @required this.isInitiallySelected,
  }) : super(key: key);

  final String value;
  final List<String> pickedValues;
  final bool isInitiallySelected;

  @override
  State<FilterValueButton> createState() => _FilterValueButtonState();
}

class _FilterValueButtonState extends State<FilterValueButton> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.isInitiallySelected ? 0 : 1,
    );
    _colorTween = ColorTween(
      begin: Colors.orange,
      end: Colors.grey,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant FilterValueButton oldWidget) {
    if (widget.isInitiallySelected) {
      _animationController.animateBack(0, duration: const Duration(milliseconds: 0));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            _colorTween.value,
          ),
        ),
        onPressed: () {
          if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
            toggleValue();
          } else {
            _animationController.animateTo(
              1,
              duration: const Duration(
                milliseconds: 0,
              ),
            );
            toggleValue();
          }
        },
        child: Text(
          widget.value,
        ),
      ),
    );
  }

  void toggleValue() {
    if (widget.pickedValues.contains(widget.value)) {
      widget.pickedValues.remove(widget.value);
    } else {
      widget.pickedValues.add(widget.value);
    }
  }
}
