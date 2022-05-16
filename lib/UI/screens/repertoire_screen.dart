import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../utils/date_handler.dart';
import '../widgets/widgets.dart';
import 'filters_screen.dart';

class RepertoireScreen extends StatefulWidget {
  const RepertoireScreen({Key key}) : super(key: key);

  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  var todayDate = DateTime.now();
  var pickedDate = DateTime.now();
  var dateInAYear = DateTime.now().add(const Duration(days: 365));
  List<String> pickedCinemas = [];
  var isCinemaListLoaded = false;
  DateTime picked;
  List<DateTime> selectableDates = [];

  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: selectableDates.isEmpty
            ? pickedDate
            : selectableDates.any((el) => el.isSameDate(pickedDate))
                ? pickedDate
                : selectableDates[0],
        firstDate: DateTime(todayDate.year, todayDate.month, todayDate.day),
        lastDate: DateTime(2101),
        selectableDayPredicate: _decideWhichDayToEnable);
    if (picked != null && picked != pickedDate) {
      pickedDate = picked;
      setState(() {
        _getRepertoire(pickedDate, pickedCinemas);
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if (selectableDates.isEmpty || selectableDates.any((el) => el.isSameDate(day))) {
      return true;
    }
    return false;
  }

  Future<void> _refreshRepertoire() async {
    _getRepertoire(pickedDate, pickedCinemas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: BlocBuilder<CinemasBloc, CinemasState>(
        builder: (context, state) {
          if (state is CinemasLoaded) {
            pickedCinemas = state.favoriteCinemaIds;

            return CinemasDrawer(
              pickedDate: pickedDate,
              pickedCinemas: pickedCinemas,
              cinemas: state.cinemas,
            );
          }
          return null;
        },
      ),
      endDrawerEnableOpenDragGesture: isCinemaListLoaded,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            children: const [
              TextSpan(text: 'Cinema City\n'),
              TextSpan(text: 'Repertuar', style: TextStyle(fontSize: 16)),
            ],
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 22),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).indicatorColor,
                ),
              ),
              child: Text(
                DateHandler.convertDateToDDMM(pickedDate),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          BlocListener<DatesCubit, DatesState>(
            listener: (context, state) {
              if (state is DatesLoaded) {
                selectableDates = state.dates;
              }
            },
            child: BlocConsumer<CinemasBloc, CinemasState>(
              listener: (context, state) {
                if (state is CinemasLoaded) {
                  BlocProvider.of<DatesCubit>(context)
                      .getDates(dateInAYear, state.favoriteCinemaIds);
                }
              },
              builder: (ctx, state) {
                return PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        enabled: state is CinemasLoaded,
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                        child: const Text("Kina"),
                      ),
                      PopupMenuItem<String>(
                        child: const Text("Filtry"),
                        // enabled: false,
                        onTap: () async {
                          // Navigator.of(context).pop();
                          await Future.delayed(const Duration(microseconds: 3));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const FiltersScreen(),
                            ),
                          );
                        },
                      ),
                    ];
                  },
                );
              },
            ),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<CinemasBloc, CinemasState>(listener: (context, state) {
        if (state is CinemasLoaded) {
          pickedCinemas = state.favoriteCinemaIds;
          _getRepertoire(pickedDate, pickedCinemas);
        }
      }, builder: (context, cinemasState) {
        if (cinemasState is CinemasLoaded) {
          return BlocBuilder<RepertoireBloc, RepertoireState>(
            builder: (context, state) {
              if (state is RepertoireLoaded) {
                return RefreshIndicator(
                  onRefresh: () => _refreshRepertoire(),
                  backgroundColor: Theme.of(context).primaryColor,
                  child: state.data.filmItems.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.separated(
                            separatorBuilder: (ctx, index) => const Divider(),
                            itemCount: state.data.filmItems.length,
                            itemBuilder: (ctx, index) {
                              return index != state.data.filmItems.length - 1
                                  ? RepertoireFilmItemWidget(
                                      state.data.filmItems[index],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: RepertoireFilmItemWidget(
                                        state.data.filmItems[index],
                                      ),
                                    );
                            },
                          ),
                        )
                      : pickedCinemas.isNotEmpty
                          ? ErrorColumn(
                              errorMessage: 'Brak filmów do wyświetlenia.',
                              buttonMessage: 'Wybierz inną datę',
                              buttonOnPressed: () {
                                _selectDate(context);
                              },
                            )
                          : ErrorColumn(
                              errorMessage: 'Brak filmów do wyświetlenia.',
                              buttonMessage: 'Wybierz kina',
                              buttonOnPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                            ),
                );
              } else if (state is RepertoireLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RepertoireError) {
                return ErrorColumn(
                  errorMessage: state.message,
                  buttonMessage: 'Odśwież',
                  buttonOnPressed: () {
                    _getRepertoire(pickedDate, pickedCinemas);
                  },
                );
              } else {
                return Container();
              }
            },
          );
        } else if (cinemasState is CinemasLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (cinemasState is CinemasError) {
          return ErrorColumn(
            errorMessage: cinemasState.message,
            buttonMessage: 'Odśwież',
            buttonOnPressed: _getCinemas,
          );
        } else {
          return Container();
        }
      }),
    );
  }

  void _getCinemas() {
    BlocProvider.of<CinemasBloc>(context).add(GetCinemas());
  }

  void _getRepertoire(DateTime date, List<String> pickedCinemas) {
    BlocProvider.of<RepertoireBloc>(context).add(
      GetRepertoire(pickedDate, pickedCinemas),
    );
  }
}
