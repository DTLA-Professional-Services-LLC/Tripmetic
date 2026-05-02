import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../l10n/l10n_helpers.dart';
import '../../map/application/map_focus_provider.dart';
import '../application/trip_providers.dart';
import '../domain/itinerary_event.dart';
import 'widgets/add_itinerary_event_sheet.dart';

class ItineraryScreen extends ConsumerWidget {
  const ItineraryScreen({super.key});

  static final _dayHeader = DateFormat('EEEE, MMMM d, y');
  static final _timeFmt = DateFormat.jm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final hiveReady = ref.watch(tripHiveStoreReadyProvider);

    Widget body;
    if (hiveReady.isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (hiveReady.hasError) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.itineraryHiveError(hiveReady.error.toString()),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
          ),
        ),
      );
    } else {
      final events = ref.watch(itineraryProvider);
      final groups = _groupByDay(events);

      if (events.isEmpty) {
        body = Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.itineraryEmpty,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        );
      } else {
        body = ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
          itemCount: groups.length,
          itemBuilder: (context, gi) {
            final g = groups[gi];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8, top: gi == 0 ? 0 : 12),
                  child: Text(
                    l10n.itineraryDayPrefix(
                      '${g.dayIndex}',
                      _dayHeader.format(g.dayDate),
                    ),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                for (var i = 0; i < g.events.length; i++)
                  _TimelineEventTile(
                    event: g.events[i],
                    isLastInDay: i == g.events.length - 1,
                    onDelete: () {
                      ref.read(itineraryProvider.notifier).removeEvent(g.events[i].id);
                    },
                    onOpenOnMap: g.events[i].latitude != null &&
                            g.events[i].longitude != null
                        ? () {
                            ref.read(mapFocusIntentProvider.notifier).state =
                                MapFocusIntent(
                              latitude: g.events[i].latitude!,
                              longitude: g.events[i].longitude!,
                              label: g.events[i].displayTitle,
                            );
                            context.go('/offline-map');
                          }
                        : null,
                  ),
              ],
            );
          },
        );
      }
    }

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Text(
                  l10n.itineraryHeader,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(child: body),
            ],
          ),
        ),
        if (!hiveReady.isLoading)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: hiveReady.hasError
                  ? null
                  : () => showAddItineraryEventSheet(context, ref),
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }
}

class _DayGroup {
  _DayGroup({
    required this.dayIndex,
    required this.dayDate,
    required this.events,
  });

  final int dayIndex;
  final DateTime dayDate;
  final List<ItineraryEvent> events;
}

List<_DayGroup> _groupByDay(List<ItineraryEvent> events) {
  if (events.isEmpty) return [];
  final byDay = <DateTime, List<ItineraryEvent>>{};
  for (final e in events) {
    final d = DateTime(e.startDateTime.year, e.startDateTime.month, e.startDateTime.day);
    byDay.putIfAbsent(d, () => []).add(e);
  }
  final keys = byDay.keys.toList()..sort();
  var idx = 1;
  return [
    for (final k in keys)
      _DayGroup(
        dayIndex: idx++,
        dayDate: k,
        events: () {
          final bucket = byDay[k];
          final list = List<ItineraryEvent>.from(bucket ?? const <ItineraryEvent>[]);
          list.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
          return list;
        }(),
      ),
  ];
}

class _TimelineEventTile extends StatelessWidget {
  const _TimelineEventTile({
    required this.event,
    required this.isLastInDay,
    required this.onDelete,
    this.onOpenOnMap,
  });

  final ItineraryEvent event;
  final bool isLastInDay;
  final VoidCallback onDelete;
  final VoidCallback? onOpenOnMap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final timeLabel = _safeFormatTime(event.startDateTime);
    final titleText = event.displayTitle;
    final locationText = event.displayLocation;
    final notesText = event.displayNotes;

    return Dismissible(
      key: ValueKey('itinerary-${event.id}-${event.startDateTime.millisecondsSinceEpoch}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        onDelete();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: cs.error.withValues(alpha: 0.35),
        child: Icon(Icons.delete_outline, color: cs.error),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: isLastInDay ? 0 : 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 76,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    timeLabel,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 18,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 2,
                          color: cs.primary.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: cs.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: cs.primary, width: 2),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 2,
                          color: isLastInDay ? Colors.transparent : cs.primary.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cs.primary.withValues(alpha: 0.35)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titleText,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (locationText.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.place_outlined, size: 16, color: cs.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locationText,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                  if (onOpenOnMap != null) ...[
                                    const SizedBox(height: 6),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton.icon(
                                        onPressed: onOpenOnMap,
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        icon: Icon(
                                          Icons.map_outlined,
                                          size: 16,
                                          color: cs.primary,
                                        ),
                                        label: Text(
                                          context.l10n.itineraryOpenOnMap,
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
                                            color: cs.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (notesText.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          notesText,
                          style: theme.textTheme.bodySmall?.copyWith(height: 1.35),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _safeFormatTime(DateTime dt) {
    try {
      return ItineraryScreen._timeFmt.format(dt);
    } catch (_) {
      return '—';
    }
  }
}
