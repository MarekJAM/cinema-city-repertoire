import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/blocs.dart';
import '../../data/models/models.dart';
import '../../i18n/strings.g.dart';
import '../widgets/widgets.dart';

class RepertoirePage extends StatelessWidget {
  const RepertoirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepertoireView();
  }
}

class RepertoireView extends StatefulWidget {
  const RepertoireView({super.key});

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
          endDrawerEnableOpenDragGesture: cinemasState.status.isSuccess,
          appBar: const RepertoireAppBar(),
          backgroundColor: context.colorScheme.surface,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Builder(
              builder: (context) {
                final repertoireMock = Repertoire.mock;
                switch (cinemasState.status) {
                  case CinemasStatus.success:
                    return BlocBuilder<RepertoireBloc, RepertoireState>(
                      builder: (context, state) {
                        switch (state) {
                          case RepertoireLoaded(
                              data: final data,
                              hasFilteringLimitedResults: final hasFilteringLimitedResults
                            ):
                            return RefreshIndicator(
                              onRefresh: () => Future.sync(
                                () => context.read<RepertoireBloc>().add(const GetRepertoire()),
                              ),
                              backgroundColor: context.colorScheme.surface,
                              child: data.filmItems.isNotEmpty
                                  ? RepertoireListPopulated(data: data)
                                  : cinemasState.pickedCinemaIds.isNotEmpty
                                      ? hasFilteringLimitedResults
                                          ? const RepertoireEmptyListFiltersOn()
                                          : const RepertoireEmptyListFiltersOff()
                                      : const RepertoireErrorPickCinemas(),
                            );
                          case RepertoireLoading():
                            return Skeletonizer(
                              child: RepertoireListPopulated(
                                data: repertoireMock,
                              ),
                            );
                          case RepertoireError(message: final message):
                            return ErrorColumn(
                              errorMessage: message,
                              buttonMessage: t.refresh,
                              buttonOnPressed: () =>
                                  context.read<RepertoireBloc>().add(const GetRepertoire()),
                            );
                        }
                      },
                    );
                  case CinemasStatus.inProgress:
                  case CinemasStatus.initial:
                    return Skeletonizer(
                      child: RepertoireListPopulated(
                        data: repertoireMock,
                      ),
                    );
                  case CinemasStatus.failure:
                    return ErrorColumn(
                      errorMessage: cinemasState.errorMessage,
                      buttonMessage: t.refresh,
                      buttonOnPressed: () => context.read<CinemasCubit>().getCinemas(),
                    );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
