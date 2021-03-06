import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../utils/date_handler.dart';
import '../widgets/widgets.dart';

class RepertoireScreen extends StatefulWidget {
  @override
  _RepertoireScreenState createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  var todayDate = DateTime.now();
  var pickedDate = DateTime.now();
  var dateInAYear = DateTime.now().add(new Duration(days: 365));
  List<String> pickedCinemas = [];
  var isCinemaListLoaded = false;
  DateTime picked;
  List<DateTime> selectableDates = [];

  Future<Null> _selectDate(BuildContext context) async {
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
        _fetchRepertoire(pickedDate, pickedCinemas);
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
    _fetchRepertoire(pickedDate, pickedCinemas);
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
              cinemas: state.data,
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
            children: [
              TextSpan(text: 'Cinema City\n'),
              TextSpan(text: 'Repertuar', style: TextStyle(fontSize: 16)),
            ],
            style: TextStyle(color: Colors.orange, fontSize: 22),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Center(
                child: Text(
                  DateHandler.convertDateToDDMM(pickedDate),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          BlocListener<DatesCubit, DatesState>(
            listener: (context, state) {
              if (state is DatesLoaded) {
                selectableDates = state.dates;
              }
            },
            child: BlocConsumer<CinemasBloc, CinemasState>(listener: (context, state) {
              if (state is CinemasLoaded) {
                BlocProvider.of<DatesCubit>(context).fetchDates(dateInAYear, state.favoriteCinemaIds);
              }
            }, builder: (ctx, state) {
              if (state is CinemasLoaded) {
                if (state.data != null) {
                  return Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () => Scaffold.of(ctx).openEndDrawer(),
                      child: Center(
                        child: Icon(
                          Icons.local_movies,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              }
              return Padding(
                padding: EdgeInsets.only(right: 20),
                child: Center(
                  child: Icon(
                    Icons.local_movies,
                    color: Colors.grey,
                  ),
                ),
              );
            }),
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<CinemasBloc, CinemasState>(listener: (context, state) {
        if (state is CinemasLoaded) {
          pickedCinemas = state.favoriteCinemaIds;
          _fetchRepertoire(pickedDate, pickedCinemas);
        }
      }, builder: (context, cinemasState) {
        if (cinemasState is CinemasLoaded) {
          return BlocBuilder<RepertoireBloc, RepertoireState>(
            builder: (context, state) {
              if (state is RepertoireLoaded) {
                return RefreshIndicator(
                  onRefresh: () => _refreshRepertoire(),
                  child: state.data.items.length != 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.separated(
                            separatorBuilder: (ctx, index) => Divider(),
                            itemCount: state.data.items.length,
                            itemBuilder: (ctx, index) {
                              return RepertoireFilmItem(
                                state.data.items[index],
                              );
                            },
                          ),
                        )
                      : pickedCinemas.length != 0
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
                return Center(child: CircularProgressIndicator());
              } else if (state is RepertoireError) {
                return ErrorColumn(
                  errorMessage: state.message,
                  buttonMessage: 'Odśwież',
                  buttonOnPressed: () {
                    _fetchRepertoire(pickedDate, pickedCinemas);
                  },
                );
              } else {
                return Container();
              }
            },
          );
        } else if (cinemasState is CinemasLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (cinemasState is CinemasError) {
          return ErrorColumn(
            errorMessage: cinemasState.message,
            buttonMessage: 'Odśwież',
            buttonOnPressed: _fetchCinemas,
          );
        } else {
          return Container();
        }
      }),
    );
  }

  void _fetchCinemas() {
    BlocProvider.of<CinemasBloc>(context).add(FetchCinemas());
  }

  void _fetchRepertoire(DateTime date, List<String> pickedCinemas) {
    BlocProvider.of<RepertoireBloc>(context).add(
      FetchRepertoire(pickedDate, pickedCinemas),
    );
  }
}
