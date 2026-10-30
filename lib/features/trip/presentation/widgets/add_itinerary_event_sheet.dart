import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n_helpers.dart';
import '../../application/trip_providers.dart';
import '../../domain/itinerary_event.dart';

Future<void> showAddItineraryEventSheet(
  BuildContext context,
  WidgetRef ref, {
  String? initialTitle,
  String? initialLocation,
  double? initialLatitude,
  double? initialLongitude,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
      child: _AddEventForm(
        initialTitle: initialTitle,
        initialLocation: initialLocation,
        initialLatitude: initialLatitude,
        initialLongitude: initialLongitude,
      ),
    ),
  );
}

class _AddEventForm extends ConsumerStatefulWidget {
  const _AddEventForm({
    this.initialTitle,
    this.initialLocation,
    this.initialLatitude,
    this.initialLongitude,
  });

  final String? initialTitle;
  final String? initialLocation;
  final double? initialLatitude;
  final double? initialLongitude;

  @override
  ConsumerState<_AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends ConsumerState<_AddEventForm> {
  late DateTime _date;
  late TimeOfDay _time;
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _date = DateTime(now.year, now.month, now.day);
    _time = TimeOfDay.fromDateTime(now);
    if (widget.initialTitle != null) _title.text = widget.initialTitle!;
    if (widget.initialLocation != null) {
      _location.text = widget.initialLocation!;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _location.dispose();
    _notes.dispose();
    super.dispose();
  }

  DateTime _composeDateTime() {
    return DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) {
      final l10n = context.l10n;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.addItineraryEnterTitle)));
      return;
    }
    final id = ref.read(itineraryProvider.notifier).newId();
    final event = ItineraryEvent(
      id: id,
      startDateTime: _composeDateTime(),
      title: title,
      location: _location.text.trim(),
      notes: _notes.text.trim(),
      latitude: widget.initialLatitude,
      longitude: widget.initialLongitude,
    );
    await ref.read(itineraryProvider.notifier).addEvent(event);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;

    InputDecoration deco(String label, {String? hint}) => InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: cs.surfaceContainer,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Text(
            l10n.addItineraryTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text(
                    MaterialLocalizations.of(context).formatCompactDate(_date),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.schedule_outlined, size: 18),
                  label: Text(
                    MaterialLocalizations.of(context).formatTimeOfDay(_time),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: deco(
              l10n.addItineraryFieldTitle,
              hint: l10n.addItineraryHintTitle,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _location,
            textCapitalization: TextCapitalization.sentences,
            decoration: deco(
              l10n.addItineraryFieldLocation,
              hint: l10n.addItineraryHintLocation,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: deco(
              l10n.addItineraryFieldNotes,
              hint: l10n.addItineraryHintNotes,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _save(),
            child: Text(l10n.addItinerarySave),
          ),
        ],
      ),
    );
  }
}
