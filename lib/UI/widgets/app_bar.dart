import 'package:cinema_city/UI/widgets/cinemas_list.dart';
import 'package:cinema_city/utils/theme_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';
import '../../data/models/models.dart';
import '../../i18n/strings.g.dart';
import '../../utils/date_helper.dart';
import '../pages/filters_page.dart';
import 'date_selector.dart';

const _repertoireAppBarHeight = 60.0;

class RepertoireAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RepertoireAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(_repertoireAppBarHeight);

  @override
  Widget build(BuildContext context) {
    return _DateChangeListener(
      child: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: const _RepertoireAppBarTitle(),
        actions: _buildRepertoireAppBarActions(context),
        backgroundColor: context.colorScheme.surface,
      ),
    );
  }
}

class RepertoireSliverAppBar extends StatelessWidget {
  const RepertoireSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return _DateChangeListener(
      child: SliverAppBar(
        automaticallyImplyLeading: false,
        floating: true,
        snap: true,
        pinned: false,
        toolbarHeight: _repertoireAppBarHeight,
        surfaceTintColor: Colors.transparent,
        title: const _RepertoireAppBarTitle(),
        actions: _buildRepertoireAppBarActions(context),
        backgroundColor: context.colorScheme.surface,
      ),
    );
  }
}

class _DateChangeListener extends StatelessWidget {
  const _DateChangeListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatesCubit, DatesState>(
      listenWhen: (previous, current) =>
          previous.status.isSuccess &&
          previous.selectedDate != current.selectedDate,
      listener: (context, state) {
        context.read<RepertoireBloc>().add(
          GetRepertoire(date: state.selectedDate),
        );
      },
      child: child,
    );
  }
}

class _RepertoireAppBarTitle extends StatelessWidget {
  const _RepertoireAppBarTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '${t.appBarTitlePart1}\n'),
          TextSpan(text: t.appBarTitlePart2, style: TextStyle(fontSize: 16)),
        ],
        style: TextStyle(color: context.colorScheme.primary, fontSize: 22),
      ),
    );
  }
}

List<Widget> _buildRepertoireAppBarActions(BuildContext context) {
  final datesCubit = context.watch<DatesCubit>();

  return [
    Padding(
      padding: const .all(8.0),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(context.colorScheme.primary),
        ),
        child: Text(
          DateHelper.convertDateToDDMM(datesCubit.state.selectedDate),
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          final date = await DateSelector.selectDate(context);
          if (date == null) return;
          if (context.mounted) {
            context.read<DatesCubit>().selectedDateChanged(date);
          }
        },
      ),
    ),
    BlocConsumer<CinemasCubit, CinemasState>(
      listenWhen: (prev, cur) => prev.status.isLoading && cur.status.isSuccess,
      listener: (context, state) {
        if (state.status.isSuccess) {
          BlocProvider.of<DatesCubit>(
            context,
          ).getDates(DateHelper.getDateTimeInAYear, state.favoriteCinemaIds);
        }
      },
      builder: (context, state) => _AppBarIconAction(
        tooltip: t.cinemas.name,
        icon: Icons.theaters_rounded,
        badgeCount: state.pickedCinemaIds.length,
        onPressed: state.status.isSuccess
            ? () => _showCinemasList(context)
            : null,
      ),
    ),
    BlocBuilder<FiltersCubit, FiltersState>(
      builder: (context, state) => _AppBarIconAction(
        tooltip: t.filters.name,
        icon: Icons.filter_alt_rounded,
        badgeCount: _activeFilterCount(state),
        onPressed: () {
          Navigator.of(context).push(FiltersPage.route());
        },
      ),
    ),
  ];
}

void _showCinemasList(BuildContext context) {
  showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: 1,
    useSafeArea: true,
    builder: (context) => const CinemasList(),
  );
}

int _activeFilterCount(FiltersState state) {
  if (state is! FiltersLoaded) return 0;

  var count = 0;
  final allGenresCount = genreMap.length + 1;

  for (final filter in state.filters) {
    switch (filter) {
      case GenreFilter(genres: final genres):
        if ((genres?.length ?? 0) < allGenresCount) count++;
      case EventTypeFilter(eventTypes: final eventTypes):
        if ((eventTypes?.length ?? 0) < allEventTypes.length) count++;
      case ScoreFilter(
        score: final score,
        showFilmsWithNoScore: final showFilmsWithNoScore,
      ):
        if ((score ?? 0) > 0 || showFilmsWithNoScore == false) count++;
    }
  }

  return count;
}

class _AppBarIconAction extends StatelessWidget {
  const _AppBarIconAction({
    required this.tooltip,
    required this.icon,
    required this.badgeCount,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final int badgeCount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox.square(
        dimension: 48,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: .center,
          children: [
            IconButton(onPressed: onPressed, icon: Icon(icon)),
            if (badgeCount > 0)
              Positioned(
                top: 6,
                right: 4,
                child: IgnorePointer(
                  child: _ActionCountIndicator(count: badgeCount),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ActionCountIndicator extends StatelessWidget {
  const _ActionCountIndicator({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: .center,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: .all(color: colorScheme.outlineVariant),
        borderRadius: .circular(8),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 10,
          fontWeight: .w600,
          height: 1,
        ),
      ),
    );
  }
}
