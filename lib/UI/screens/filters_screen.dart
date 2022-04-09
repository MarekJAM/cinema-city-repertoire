import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../bloc/blocs.dart';

var _genres = genreMap.values.toList()..sort();
var _eventTypes = eventTypes;
final List<String> _pickedGenres = [];
final List<String> _pickedEventTypes = [];

class FiltersScreen extends StatefulWidget {
  const FiltersScreen();

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void initState() {
    _pickedGenres.addAll(_genres);
    _pickedEventTypes.addAll(_eventTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: BlocBuilder<FiltersCubit, FiltersState>(builder: (context, state) {
              if (state is FiltersLoaded) {
                state.filters.forEach(
                  (filter) {
                    if (filter is GenreFilter) {
                      _pickedGenres.clear();
                      _pickedGenres.addAll(filter.genres);
                    } else if (filter is EventTypeFilter) {
                      _pickedEventTypes.clear();
                      _pickedEventTypes.addAll(filter.eventTypes);
                    }
                  },
                );
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  FilterMultiSelectDialog(
                    title: "Gatunek",
                    values: _genres,
                    pickedValues: _pickedGenres,
                  ),
                  FilterMultiSelectDialog(
                    title: "Rodzaj seansu",
                    values: _eventTypes,
                    pickedValues: _pickedEventTypes,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Powrót'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<FiltersCubit>(context).saveFilters(
                            [
                              GenreFilter(
                                [..._pickedGenres],
                              ),
                              EventTypeFilter(
                                [..._pickedEventTypes],
                              )
                            ],
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Zastosuj'),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class FilterMultiSelectDialog extends StatelessWidget {
  const FilterMultiSelectDialog({
    @required this.title,
    @required this.values,
    @required this.pickedValues,
  });

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DialogColumn(
                  title: title,
                  values: values,
                  pickedValues: pickedValues,
                ),
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(title),
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}

class DialogColumn extends StatefulWidget {
  const DialogColumn({
    Key key,
    @required this.title,
    @required this.values,
    @required this.pickedValues,
  }) : super(key: key);

  final String title;
  final List<String> values;
  final List<String> pickedValues;

  @override
  State<DialogColumn> createState() => _DialogColumnState();
}

class _DialogColumnState extends State<DialogColumn> {
  List<String> tempPickedValues = [];

  @override
  void initState() {
    tempPickedValues.addAll(widget.pickedValues);
    super.initState();
  }

  bool _isInitiallySelected(String val) => tempPickedValues.contains(val);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.cancel,
                ),
              )
            ],
          ),
          Divider(),
          Wrap(
            children: [
              for (int i = 0; i < widget.values.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FilterValueButton(
                    value: widget.values[i],
                    pickedValues: tempPickedValues,
                    isInitiallySelected: _isInitiallySelected(
                      widget.values[i],
                    ),
                  ),
                ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    tempPickedValues.clear();
                    tempPickedValues.addAll(widget.values);
                  });
                },
                child: Text('Reset'),
              ),
              SizedBox(
                width: 5,
              ),
              OutlinedButton(
                onPressed: () {
                  widget.pickedValues.clear();
                  widget.pickedValues.addAll(tempPickedValues);
                  Navigator.of(context).pop();
                },
                child: Text('Zatwierdź'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

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
      duration: Duration(milliseconds: 300),
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
      _animationController.animateBack(0, duration: Duration(milliseconds: 0));
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
              duration: Duration(
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
