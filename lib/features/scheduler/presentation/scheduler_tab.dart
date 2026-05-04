import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n_helpers.dart';
import '../application/availability.dart';
import '../application/scheduler_logic.dart';
import '../application/scheduler_notifier.dart';
import '../application/scheduler_state.dart';
import 'widgets/timezone_picker_sheet.dart';

class SchedulerTab extends ConsumerStatefulWidget {
  const SchedulerTab({super.key});

  @override
  ConsumerState<SchedulerTab> createState() => _SchedulerTabState();
}

class _SchedulerTabState extends ConsumerState<SchedulerTab> {
  Future<void> _pickBaseTimezone() async {
    final s = ref.read(schedulerProvider).requireValue;
    final picked = await showTimezonePickerSheet(
      context,
      selectedTimezoneId: s.baseTimezoneId,
    );
    if (picked == null || !context.mounted) return;
    ref.read(schedulerProvider.notifier).setBaseTimezone(picked);
  }

  Future<void> _pickConvertedTimezone(int index) async {
    final s = ref.read(schedulerProvider).requireValue;
    final picked = await showTimezonePickerSheet(
      context,
      selectedTimezoneId: s.convertedTimezoneIds[index],
    );
    if (picked == null || !context.mounted) return;
    ref.read(schedulerProvider.notifier).setConvertedAt(index, picked);
  }

  Future<void> _pickDate() async {
    final s = ref.read(schedulerProvider).requireValue;
    final picked = await showDatePicker(
      context: context,
      initialDate: s.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => child!,
    );
    if (picked != null && context.mounted) {
      ref.read(schedulerProvider.notifier).setDate(picked);
    }
  }

  Future<void> _pickTime() async {
    final s = ref.read(schedulerProvider).requireValue;
    final picked = await showTimePicker(
      context: context,
      initialTime: s.timeOfDay,
      builder: (context, child) => child!,
    );
    if (picked != null && context.mounted) {
      ref.read(schedulerProvider.notifier).setTimeFromTimeOfDay(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(schedulerProvider);
    return async.when(
      skipLoadingOnReload: true,
      data: (s) => _buildLoaded(context, s),
      loading: () => const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SafeArea(
        child: Center(child: Text('$e')),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, SchedulerState s) {
    final computation = SchedulerComputation.compute(
      baseTimezoneId: s.baseTimezoneId,
      convertedTimezoneIds: s.convertedTimezoneIds,
      date: s.date,
      time: s.timeOfDay,
    );
    final base = computation.baseLocal;

    final dateLabel =
        '${s.date.month.toString().padLeft(2, '0')}/${s.date.day.toString().padLeft(2, '0')}/${s.date.year}';
    final timeLabel = s.timeOfDay.format(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final zoneShort = s.baseTimezoneId.split('/').last.replaceAll('_', ' ');

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  l10n.schedulerTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Text(
                l10n.schedulerSubtitle,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary.withValues(alpha: 0.45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.schedulerBaseLocation,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Tooltip(
                      message: l10n.schedulerBaseTooltip(zoneShort),
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _TimezoneSelectorTile(
                  label: s.baseTimezoneId,
                  abbreviation: base.timeZoneName,
                  onTap: _pickBaseTimezone,
                  compact: true,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickDate,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cs.onSurface,
                          side: BorderSide(color: cs.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(Icons.calendar_today_outlined, color: cs.primary, size: 16),
                        label: Text(dateLabel, style: theme.textTheme.labelLarge),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickTime,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cs.onSurface,
                          side: BorderSide(color: cs.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(Icons.schedule, color: cs.primary, size: 16),
                        label: Text(timeLabel, style: theme.textTheme.labelLarge),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.schedulerMeetingTime,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      s.timeOfDay.format(context),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: s.selectedMeetingHours.clamp(0.0, 24.0),
                  min: 0,
                  max: 24,
                  divisions: 48,
                  label: s.timeOfDay.format(context),
                  onChanged: (v) {
                    ref.read(schedulerProvider.notifier).setSelectedMeetingHours(v);
                  },
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      formatSchedulerTime(base),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      '  ·  ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formatSchedulerDateShort(base),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 4),
            child: Text(
              l10n.schedulerConvertedCities,
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          for (var i = 0; i < computation.converted.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ConvertedTimezoneCard(
                slot: computation.converted[i],
                availability: availabilityForLocalTime(computation.converted[i].localTime),
                onChangeTimezone: () => _pickConvertedTimezone(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _TimezoneSelectorTile extends StatelessWidget {
  const _TimezoneSelectorTile({
    required this.label,
    required this.abbreviation,
    required this.onTap,
    this.compact = false,
  });

  final String label;
  final String abbreviation;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final pad = compact
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 6)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    final iconSize = compact ? 18.0 : 22.0;
    final monoSize = compact ? 11.5 : 13.0;

    return Material(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: pad,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.primary.withValues(alpha: 0.75)),
          ),
          child: Row(
            children: [
              Icon(Icons.public, color: cs.primary, size: iconSize),
              SizedBox(width: compact ? 8 : 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      maxLines: compact ? 1 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                        fontSize: monoSize,
                        height: 1.2,
                      ),
                    ),
                    if (!compact) ...[
                      const SizedBox(height: 2),
                      Text(
                        '($abbreviation)',
                        style: theme.textTheme.labelLarge,
                      ),
                    ] else
                      Text(
                        abbreviation,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: cs.primary, size: compact ? 18 : 22),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConvertedTimezoneCard extends StatelessWidget {
  const _ConvertedTimezoneCard({
    required this.slot,
    required this.availability,
    required this.onChangeTimezone,
  });

  final ConvertedSlot slot;
  final AvailabilityStatus availability;
  final VoidCallback onChangeTimezone;

  static Color _outlineFor(AvailabilityStatus a) {
    return switch (a) {
      AvailabilityStatus.working => const Color(0xFF22C55E),
      AvailabilityStatus.marginal => const Color(0xFFF59E0B),
      AvailabilityStatus.sleeping => const Color(0xFFDC2626),
    };
  }

  static IconData _iconFor(AvailabilityStatus a) {
    return switch (a) {
      AvailabilityStatus.working => Icons.check_circle_outline,
      AvailabilityStatus.marginal => Icons.warning_amber_outlined,
      AvailabilityStatus.sleeping => Icons.bedtime_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final outline = _outlineFor(availability);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: outline, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: outline.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _TimezoneSelectorTile(
                    label: slot.timezoneId,
                    abbreviation: slot.localTime.timeZoneName,
                    onTap: onChangeTimezone,
                    compact: true,
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(_iconFor(availability), color: outline, size: 18),
                    const SizedBox(height: 2),
                    Text(
                      schedulerAvailabilityLabel(context.l10n, availability),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: outline,
                        fontSize: 10,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _DayBadge(relation: slot.dayRelation, compact: true),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatSchedulerTime(slot.localTime),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15,
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Text(
                    formatSchedulerDateShort(slot.localTime),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DayBadge extends StatelessWidget {
  const _DayBadge({required this.relation, this.compact = false});

  final DayRelation relation;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline),
      ),
      child: Text(
        schedulerDayRelationLabel(context.l10n, relation),
        style: compact
            ? theme.textTheme.labelSmall?.copyWith(fontSize: 10)
            : theme.textTheme.labelLarge,
      ),
    );
  }
}
