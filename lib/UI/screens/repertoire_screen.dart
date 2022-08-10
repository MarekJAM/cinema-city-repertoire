import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../widgets/date_selector.dart';
import '../widgets/widgets.dart';
import 'filters_screen.dart';

class RepertoireScreen extends StatefulWidget {
  const RepertoireScreen({Key? key}) : super(key: key);

  @override
  State<RepertoireScreen> createState() => _RepertoireScreenState();
}

class _RepertoireScreenState extends State<RepertoireScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = context.select<DatesCubit, DateTime>((cubit) => cubit.state.selectedDate);
    final cinemasState = context.watch<CinemasCubit>().state;

    return Scaffold(
      endDrawer: cinemasState.status.isSuccess
          ? CinemasDrawer(
              pickedDate: selectedDate,
              pickedCinemas: [...cinemasState.pickedCinemaIds],
              cinemas: cinemasState.cinemas,
            )
          : null,
      backgroundColor: Colors.black,
      endDrawerEnableOpenDragGesture: cinemasState.status.isSuccess,
      appBar: const RepertoireAppBar(),
      body: BlocConsumer<CinemasCubit, CinemasState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<RepertoireBloc>().add(
                  GetRepertoire(
                    date: selectedDate,
                    allCinemas: state.cinemas,
                    pickedCinemaIds: state.pickedCinemaIds,
                  ),
                );
          }
        },
        builder: (context, cinemasState) {
          if (cinemasState.status.isSuccess) {
            return BlocBuilder<RepertoireBloc, RepertoireState>(
              builder: (context, state) {
                if (state is RepertoireLoaded) {
                  return RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => context.read<RepertoireBloc>().add(const GetRepertoire()),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: state.data.filmItems.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ListView.builder(
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
                        : cinemasState.pickedCinemaIds.isNotEmpty
                            ? state.hasFilteringLimitedResults
                                ? ErrorColumn(
                                    errorMessage:
                                        'Brak filmów do wyświetlenia. Wybierz inną datę lub dostosuj filtry.',
                                    buttons: [
                                      ElevatedButton(
                                        onPressed: () {
                                          DateSelector.selectDate(context);
                                        },
                                        child: const Text(
                                          "Wybierz inną datę",
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const FiltersScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Dostosuj filtry",
                                        ),
                                      ),
                                    ],
                                  )
                                : ErrorColumn(
                                    errorMessage: 'Brak filmów do wyświetlenia.',
                                    buttonMessage: 'Wybierz inną datę',
                                    buttonOnPressed: () {
                                      DateSelector.selectDate(context);
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
                } else if (state is RepertoireError) {
                  return ErrorColumn(
                    errorMessage: state.message,
                    buttonMessage: 'Odśwież',
                    buttonOnPressed: () =>
                        context.read<RepertoireBloc>().add(const GetRepertoire()),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (cinemasState.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (cinemasState.status.isFailure) {
            return ErrorColumn(
              errorMessage: cinemasState.errorMessage,
              buttonMessage: 'Odśwież',
              buttonOnPressed: () => context.read<CinemasCubit>().getCinemas(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
