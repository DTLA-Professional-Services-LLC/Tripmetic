import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../application/bucket_list_provider.dart';
import '../domain/travel_constants.dart';
import '../domain/travel_destination.dart';
import 'bucket_list_ui_helpers.dart';

Future<void> showBucketDestinationEditor(
  BuildContext context, {
  TravelDestination? existing,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => BucketDestinationEditorSheet(existing: existing),
  );
}

class BucketDestinationEditorSheet extends ConsumerStatefulWidget {
  const BucketDestinationEditorSheet({super.key, this.existing});

  final TravelDestination? existing;

  @override
  ConsumerState<BucketDestinationEditorSheet> createState() =>
      _BucketDestinationEditorSheetState();
}

class _BucketDestinationEditorSheetState
    extends ConsumerState<BucketDestinationEditorSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _city;
  late final TextEditingController _countryQuery;
  late final FocusNode _countryFocus;

  String? _selectedCountry;
  String? _selectedRegion;

  late TravelDestinationCategory _category;
  DateTime? _start;
  DateTime? _end;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _city = TextEditingController(text: e?.city ?? '');
    final existingCountry = e?.country;
    _selectedCountry = existingCountry != null &&
            kStandardCountryNames.contains(existingCountry)
        ? existingCountry
        : null;
    _countryQuery = TextEditingController(
      text: _selectedCountry ?? '',
    );
    final regions = _selectedCountry == null
        ? null
        : kStateProvinceByCountry[_selectedCountry!];
    final existingRegion = e?.state;
    if (regions != null &&
        existingRegion != null &&
        regions.contains(existingRegion)) {
      _selectedRegion = existingRegion;
    }
    _category = e?.category ?? TravelDestinationCategory.want;
    _start = e?.startDate;
    _end = e?.endDate;
    _countryFocus = FocusNode();
  }

  @override
  void dispose() {
    _city.dispose();
    _countryQuery.dispose();
    _countryFocus.dispose();
    super.dispose();
  }

  Future<void> _pickTripDateRange(AppLocalizations l10n) async {
    if (_isSaving) return;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var startDay = _start != null
        ? DateTime(_start!.year, _start!.month, _start!.day)
        : today;
    var endDay = _end != null
        ? DateTime(_end!.year, _end!.month, _end!.day)
        : startDay.add(const Duration(days: 7));
    if (endDay.isBefore(startDay)) {
      endDay = startDay;
    }

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: startDay, end: endDay),
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      builder: (ctx, child) {
        final theme = Theme.of(ctx);
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(primary: AppColors.accent),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked == null || !mounted) return;
    setState(() {
      _start = DateTime(picked.start.year, picked.start.month, picked.start.day);
      _end = DateTime(picked.end.year, picked.end.month, picked.end.day);
    });
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    var selectedCountry = _resolvedCountry();

    if (selectedCountry == null || selectedCountry.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListValidationRequired)),
      );
      return;
    }

    final requiredRegions = kStateProvinceByCountry[selectedCountry];
    if (requiredRegions != null &&
        (_selectedRegion == null || _selectedRegion!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListValidationRequired)),
      );
      return;
    }

    DateTime? sd;
    DateTime? ed;
    if (_category == TravelDestinationCategory.upcoming) {
      sd = _start;
      ed = _end;
      if (sd == null || ed == null || ed.isBefore(sd)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.bucketListValidationDates)),
        );
        return;
      }
    }

    final cityTrim = _city.text.trim();
    final addressParts = <String>[
      cityTrim,
      if (_selectedRegion != null && _selectedRegion!.isNotEmpty)
        _selectedRegion!,
      selectedCountry,
    ];
    final address = addressParts.join(', ');

    setState(() => _isSaving = true);
    double lat;
    double lng;
    try {
      final locations = await locationFromAddress(address);
      if (locations.isEmpty) {
        throw StateError('empty geocode');
      }
      final loc = locations.first;
      lat = loc.latitude;
      lng = loc.longitude;
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListGeocodeNotFound)),
      );
      return;
    }

    final dest = TravelDestination(
      id: widget.existing?.id ??
          ref.read(bucketListProvider.notifier).newId(),
      city: cityTrim,
      country: selectedCountry,
      state: _selectedRegion,
      latitude: lat,
      longitude: lng,
      category: _category,
      startDate: sd,
      endDate: ed,
    );

    final notifier = ref.read(bucketListProvider.notifier);
    try {
      if (widget.existing == null) {
        await notifier.addDestination(dest);
      } else {
        await notifier.editDestination(dest);
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListCloudSyncFailed('$e'))),
      );
    }
  }

  Iterable<String> _countryOptions(TextEditingValue value) {
    final q = value.text.trim().toLowerCase();
    if (q.isEmpty) {
      return kStandardCountryNames.take(32);
    }
    return kStandardCountryNames
        .where(
          (c) =>
              c.toLowerCase().startsWith(q) || c.toLowerCase().contains(q),
        )
        .take(48);
  }

  /// Canonical selection from picker or an exact typed country name.
  String? _resolvedCountry() {
    final typed = _countryQuery.text.trim();
    if (_selectedCountry != null && _selectedCountry!.isNotEmpty) {
      return _selectedCountry;
    }
    if (kStandardCountryNames.contains(typed)) return typed;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final upcoming = _category == TravelDestinationCategory.upcoming;
    final countryForRegions = _resolvedCountry();
    final needsRegion = countryForRegions != null &&
        kStateProvinceByCountry.containsKey(countryForRegions);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: AbsorbPointer(
        absorbing: _isSaving,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderSubtle,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.existing == null
                      ? l10n.bucketListAddDestination
                      : l10n.bucketListEditDestination,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _city,
                  decoration: InputDecoration(
                    labelText: l10n.bucketListFieldCity,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? l10n.bucketListValidationRequired
                      : null,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                RawAutocomplete<String>(
                  textEditingController: _countryQuery,
                  focusNode: _countryFocus,
                  optionsBuilder: _countryOptions,
                  displayStringForOption: (s) => s,
                  fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: l10n.bucketListFieldCountry,
                        hintText: 'Search countries',
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final t = v?.trim() ?? '';
                        if (t.isEmpty) return l10n.bucketListValidationRequired;
                        if (!kStandardCountryNames.contains(t)) {
                          return l10n.bucketListValidationRequired;
                        }
                        return null;
                      },
                      onChanged: (_) {
                        setState(() {
                          final t = _countryQuery.text.trim();
                          if (kStandardCountryNames.contains(t)) {
                            _selectedCountry = t;
                            final regions = kStateProvinceByCountry[t];
                            if (regions == null ||
                                _selectedRegion == null ||
                                !regions.contains(_selectedRegion)) {
                              _selectedRegion = null;
                            }
                          } else {
                            _selectedCountry = null;
                            _selectedRegion = null;
                          }
                        });
                      },
                      onFieldSubmitted: (_) => onSubmit(),
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.surfaceContainer,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 240),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    option,
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (selection) {
                    setState(() {
                      _selectedCountry = selection;
                      _countryQuery.text = selection;
                      final regions = kStateProvinceByCountry[selection];
                      if (regions == null ||
                          _selectedRegion == null ||
                          !regions.contains(_selectedRegion)) {
                        _selectedRegion = null;
                      }
                    });
                  },
                ),
                if (needsRegion) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    key: ValueKey(countryForRegions),
                    initialValue: _selectedRegion,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: l10n.bucketListFieldRegionHint,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      for (final region
                          in kStateProvinceByCountry[countryForRegions]!)
                        DropdownMenuItem<String>(
                          value: region,
                          child: Text(region),
                        ),
                    ],
                    validator: (v) => v == null || v.isEmpty
                        ? l10n.bucketListValidationRequired
                        : null,
                    onChanged: (value) {
                      setState(() => _selectedRegion = value);
                    },
                  ),
                ],
                const SizedBox(height: 12),
                DropdownButtonFormField<TravelDestinationCategory>(
                  key: ValueKey(_category),
                  initialValue: _category,
                  decoration: InputDecoration(
                    labelText: l10n.bucketListFieldCategory,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    for (final c in TravelDestinationCategory.values)
                      DropdownMenuItem(
                        value: c,
                        child: Text(categoryLabel(l10n, c)),
                      ),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _category = v);
                  },
                ),
                if (upcoming) ...[
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _isSaving ? null : () => _pickTripDateRange(l10n),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          color: AppColors.accent,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _start != null && _end != null
                                ? formatBucketListTripDateRange(
                                    _start!.toLocal(),
                                    _end!.toLocal(),
                                    Localizations.localeOf(context)
                                        .toLanguageTag(),
                                  )
                                : l10n.bucketListFieldTripDates,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: _start != null && _end != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed:
                      _isSaving ? null : () async => _submit(l10n),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onAccent,
                          ),
                        )
                      : Text(l10n.bucketListSave),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
