import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../widgets/date_selector.dart';
import '../widgets/widgets.dart';
import 'filters_page.dart';

class RepertoirePage extends StatelessWidget {
  const RepertoirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RepertoireView();
  }
}

class RepertoireView extends StatefulWidget {
  const RepertoireView({Key? key}) : super(key: key);

  @override
  State<RepertoireView> createState() => _RepertoireViewState();
}

class _RepertoireViewState extends State<RepertoireView> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = context.select<DatesCubit, DateTime>((cubit) => cubit.state.selectedDate);

    return BlocConsumer<CinemasCubit, CinemasState>(
      listenWhen: (prev, cur) =>
          prev.status != cur.status || prev.pickedCinemaIds != cur.pickedCinemaIds,
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
      buildWhen: (prev, cur) =>
          prev.status != cur.status || prev.pickedCinemaIds != cur.pickedCinemaIds,
      builder: (context, cinemasState) {
        return Scaffold(
          endDrawer: cinemasState.status.isSuccess ? const CinemasDrawer() : null,
          backgroundColor: Colors.black,
          endDrawerEnableOpenDragGesture: cinemasState.status.isSuccess,
          appBar: const RepertoireAppBar(),
          body: Builder(
            builder: (context) {
              switch (cinemasState.status) {
                case CinemasStatus.success:
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
                                                  FiltersPage.route(),
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
                case CinemasStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case CinemasStatus.failure:
                  return ErrorColumn(
                    errorMessage: cinemasState.errorMessage,
                    buttonMessage: 'Odśwież',
                    buttonOnPressed: () => context.read<CinemasCubit>().getCinemas(),
                  );
                default:
                  return Container();
              }
            },
          ),
        );
      },
    );
  }
}
