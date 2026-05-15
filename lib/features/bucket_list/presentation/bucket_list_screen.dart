import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' show ImageFilter;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/navigation/tripmetic_home_navigation.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_mode_provider.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/tripmetic_app_bar_title.dart';
import '../../../shared/widgets/tripmetic_hub_app_bar_actions.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../../paywall/presentation/pro_paywall_sheet.dart';
import '../application/bucket_list_auth_providers.dart';
import '../application/bucket_list_provider.dart';
import '../domain/bucket_list_choropleth.dart';
import '../domain/travel_destination.dart';
import '../domain/travel_metrics.dart';
import 'bucket_list_editor_sheet.dart';
import 'bucket_list_popular_destinations_view.dart';
import 'bucket_list_share_format.dart';
import 'bucket_list_ui_helpers.dart';

/// Destinations that appear on the map (been / live / lived only).
List<TravelDestination> _destinationsOnMap(List<TravelDestination> all) =>
    all.where(TravelExplorationMetrics.countsTowardExploration).toList();

/// Must match [OfflineMapScreen] — Mapbox public token for map views.
const String kBucketListMapboxPublicToken =
    'pk.eyJ1IjoiZHRsYXBybyIsImEiOiJjbW84YmNoMXkwZnBzMm9uNTM1djkzcXpnIn0.Nt002rr9FLmn6eMEbqGPzA';

int _markerArgb(TravelDestinationCategory c) => switch (c) {
      TravelDestinationCategory.been => 0xFF4CAF50,
      TravelDestinationCategory.want => 0xFFFFA000,
      TravelDestinationCategory.live => 0xFF2196F3,
      TravelDestinationCategory.lived => 0xFF9C27B0,
      TravelDestinationCategory.upcoming => 0xFFFF9800,
    };

String _bucketListMapStyleUri(ThemeMode mode) =>
    mode == ThemeMode.dark ? MapboxStyles.DARK : MapboxStyles.LIGHT;

double _symbolSortKey(TravelDestinationCategory c) =>
    TravelDestinationCategory.values.indexOf(c).toDouble();

/// Default fallback when Firebase has no display name on the current user.
const String _kShareMapDefaultName = 'Rafael';

/// Resolves the share-watermark name from the *reactive* [firebaseAuthUserProvider]
/// snapshot (see [_BucketListMapShareOverlays]) so updating display name in the
/// account screen propagates without an app restart.
String _shareMapDisplayName(User? user) {
  final display = user?.displayName?.trim();
  if (display != null && display.isNotEmpty) return display;
  return _kShareMapDefaultName;
}

int _shareMapUniqueVisitedCityCount(List<TravelDestination> all) {
  final keys = <String>{};
  for (final d in all) {
    if (!TravelExplorationMetrics.countsTowardExploration(d)) continue;
    final c = d.city.trim().toLowerCase();
    final co = d.country.trim().toLowerCase();
    if (c.isEmpty && co.isEmpty) continue;
    keys.add('$c|$co');
  }
  return keys.length;
}

/// Tiered “vs population” share line: 0 countries → 0%; else 89% baseline +1%/country, cap 99%.
int _shareMapPopulationComparePercent(int visitedCountries) {
  if (visitedCountries <= 0) return 0;
  return (89 + (visitedCountries - 1)).clamp(0, 99);
}

/// Native bridge so sharing can call [MapboxMap.snapshot] (platform-view safe).
class BucketListMapSnapshotBridge {
  Future<Uint8List?> Function()? snapshot;
}

/// iOS: Mapbox is a platform view — [Screenshot] misses the map. We capture the
/// map via [MapboxMap.snapshot] and Flutter overlays separately, then merge.
Uint8List? _compositeBucketListSharePng(Uint8List? mapPng, Uint8List? overlayPng) {
  if (mapPng != null &&
      mapPng.isNotEmpty &&
      overlayPng != null &&
      overlayPng.isNotEmpty) {
    try {
      final base = img.decodePng(mapPng);
      final top = img.decodePng(overlayPng);
      if (base != null && top != null) {
        final stretched = top.width == base.width && top.height == base.height
            ? top
            : img.copyResize(
                top,
                width: base.width,
                height: base.height,
                interpolation: img.Interpolation.linear,
              );
        img.compositeImage(base, stretched, dstX: 0, dstY: 0);
        return Uint8List.fromList(img.encodePng(base));
      }
    } catch (_) {}
  }
  if (mapPng != null && mapPng.isNotEmpty) return mapPng;
  if (overlayPng != null && overlayPng.isNotEmpty) return overlayPng;
  return null;
}

class BucketListScreen extends ConsumerStatefulWidget {
  const BucketListScreen({super.key});

  @override
  ConsumerState<BucketListScreen> createState() => _BucketListScreenState();
}

class _BucketListScreenState extends ConsumerState<BucketListScreen> {
  _ViewMode _mode = _ViewMode.list;
  final BucketListMapSnapshotBridge _mapSnapshotBridge =
      BucketListMapSnapshotBridge();
  final ScreenshotController _screenshotController = ScreenshotController();
  final ScreenshotController _overlayScreenshotController =
      ScreenshotController();

  /// True while the share PNG is being captured. Used to hide the
  /// "Tap a marker for details" legend so it does not appear in the export.
  bool _capturingShareImage = false;

  Future<void> _onBackPressed() async {
    if (!mounted) return;
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
    } else {
      goTripmeticHome(context, ref, selectFeatureId: NavFeatureIds.currency);
    }
  }

  Future<void> _shareBucketList() async {
    final l10n = context.l10n;
    final items = ref.read(bucketListProvider).value ?? const [];
    final text = buildBucketListShareText(
      destinations: items,
      categoryTitle: (c) => categoryLabel(l10n, c),
    );

    Uint8List? png;

    final dpr = MediaQuery.devicePixelRatioOf(context);

    if (mounted) setState(() => _capturingShareImage = true);
    try {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;

      try {
        if (Platform.isIOS) {
          Uint8List? mapPng;
          try {
            mapPng = await _mapSnapshotBridge.snapshot?.call();
          } catch (_) {}
          Uint8List? overlayPng;
          try {
            overlayPng =
                await _overlayScreenshotController.capture(pixelRatio: dpr);
          } catch (_) {}
          png = _compositeBucketListSharePng(mapPng, overlayPng);
          if (png == null || png.isEmpty) {
            try {
              png = await _mapSnapshotBridge.snapshot?.call();
            } catch (_) {}
          }
        } else {
          try {
            png = await _screenshotController.capture(pixelRatio: dpr);
          } catch (_) {}
          if (png == null || png.isEmpty) {
            try {
              png = await _mapSnapshotBridge.snapshot?.call();
            } catch (_) {}
          }
        }
      } catch (_) {}
    } finally {
      if (mounted) setState(() => _capturingShareImage = false);
    }

    try {
      if (png != null && png.isNotEmpty) {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/tripmetic_bucket_map_${DateTime.now().millisecondsSinceEpoch}.png',
        );
        await file.writeAsBytes(png);

        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path)],
            text: text,
            subject: l10n.bucketListShareSummarySubject,
          ),
        );
      } else {
        await SharePlus.instance.share(
          ShareParams(
            text: text,
            subject: l10n.bucketListShareSummarySubject,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.bucketListShareFailed('$e'))),
      );
    }
  }

  void _showDestinationSheet(BuildContext context, TravelDestination d) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              d.displayName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 88,
                  child: Text(
                    l10n.bucketListDetailCategory,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    categoryLabel(l10n, d.category),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            if (d.isUpcoming &&
                d.startDate != null &&
                d.endDate != null) ...[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 88,
                    child: Text(
                      l10n.bucketListDetailDates,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      formatBucketListTripDateRange(
                        d.startDate!.toLocal(),
                        d.endDate!.toLocal(),
                        Localizations.localeOf(ctx).toLanguageTag(),
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bucketAsync = ref.watch(bucketListProvider);
    final isPro = ref.watch(isTripmeticProProvider);

    return bucketAsync.when(
      loading: () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) unawaited(_onBackPressed());
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: TripmeticAppBarTitle.toolbarHeightWithSubtitle,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: _onBackPressed,
            ),
            title: TripmeticAppBarTitle(subtitle: l10n.bucketListTitle),
            actions: tripmeticHubAppBarActions(context, ref),
          ),
          body: ProGlassOverlay(
            featureId: NavFeatureIds.bucketList,
            isPro: isPro,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
      error: (e, _) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) unawaited(_onBackPressed());
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: TripmeticAppBarTitle.toolbarHeightWithSubtitle,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: _onBackPressed,
            ),
            title: TripmeticAppBarTitle(subtitle: l10n.bucketListTitle),
            actions: tripmeticHubAppBarActions(context, ref),
          ),
          body: ProGlassOverlay(
            featureId: NavFeatureIds.bucketList,
            isPro: isPro,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.bucketListCloudSyncFailed('$e'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => ref.invalidate(bucketListProvider),
                      child: Text(l10n.bucketListRetry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      data: (destinations) {
        final metrics = TravelExplorationMetrics.fromDestinations(destinations);
        final mapStyleUri =
            _bucketListMapStyleUri(ref.watch(themeModeProvider));

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) unawaited(_onBackPressed());
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: TripmeticAppBarTitle.toolbarHeightWithSubtitle,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: _onBackPressed,
              ),
              title: TripmeticAppBarTitle(subtitle: l10n.bucketListTitle),
              actions: [
                ...tripmeticHubAppBarActions(context, ref),
                IconButton(
                  tooltip: l10n.bucketListShareTooltip,
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: () {
                    if (!isPro) {
                      ProPaywallSheet.show(context);
                      return;
                    }
                    _shareBucketList();
                  },
                ),
              ],
            ),
            floatingActionButton: _mode == _ViewMode.list && isPro
                ? FloatingActionButton(
                    onPressed: () => showBucketDestinationEditor(context),
                    child: const Icon(Icons.add_location_alt_rounded),
                  )
                : null,
            body: ProGlassOverlay(
              featureId: NavFeatureIds.bucketList,
              isPro: isPro,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        l10n.bucketListSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _TravelStatsCard(metrics: metrics),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SegmentedButton<_ViewMode>(
                        segments: [
                          ButtonSegment<_ViewMode>(
                            value: _ViewMode.list,
                            label: Text(l10n.bucketListViewModeList),
                            icon:
                                const Icon(Icons.view_list_rounded, size: 18),
                          ),
                          ButtonSegment<_ViewMode>(
                            value: _ViewMode.map,
                            label: Text(l10n.bucketListViewModeMap),
                            icon: const Icon(Icons.map_rounded, size: 18),
                          ),
                          ButtonSegment<_ViewMode>(
                            value: _ViewMode.popular,
                            label: Text(l10n.bucketListViewModePopular),
                            icon: const Icon(Icons.explore_rounded, size: 18),
                          ),
                        ],
                        selected: <_ViewMode>{_mode},
                        onSelectionChanged: (s) {
                          setState(() => _mode = s.first);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: IndexedStack(
                        index: switch (_mode) {
                          _ViewMode.list => 0,
                          _ViewMode.map => 1,
                          _ViewMode.popular => 2,
                        },
                        children: [
                          _BucketListList(
                            destinations: destinations,
                            allowEditing: isPro,
                            onEdit: (d) => showBucketDestinationEditor(
                              context,
                              existing: d,
                            ),
                            onDismissed: (id) => ref
                                .read(bucketListProvider.notifier)
                                .deleteDestination(id),
                          ),
                          _BucketListMap(
                            destinations: destinations,
                            styleUri: mapStyleUri,
                            token: kBucketListMapboxPublicToken,
                            screenshotController: _screenshotController,
                            overlayScreenshotController:
                                _overlayScreenshotController,
                            snapshotBridge: _mapSnapshotBridge,
                            showLegend: !_capturingShareImage,
                            useSimpleGlassForExport: _capturingShareImage,
                            onMarkerTap: (d) =>
                                _showDestinationSheet(context, d),
                          ),
                          BucketListPopularDestinationsView(
                            destinations: destinations,
                            allowEditing: isPro,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        );
      },
    );
  }
}

enum _ViewMode { list, map, popular }

class _TravelStatsCard extends StatelessWidget {
  const _TravelStatsCard({required this.metrics});

  final TravelExplorationMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final worldPct = metrics.worldExploredPercent.clamp(0, 100);
    final accentText = AppColors.accentOnSurface(theme.brightness);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withValues(alpha: 0.45)),
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        collapsedTextColor: cs.onSurface,
        textColor: cs.onSurface,
        collapsedIconColor: cs.onSurfaceVariant,
        iconColor: accentText,
        tilePadding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
        childrenPadding:
            const EdgeInsets.only(left: 14, right: 14, bottom: 14),
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          l10n.bucketListStatWorld,
          style: theme.textTheme.titleSmall?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.bucketListStatSubtitle(
                        metrics.uniqueCountriesVisited,
                        TravelExplorationMetrics.kWorldCountryDenominator,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    '${worldPct.toStringAsFixed(1)}%',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: worldPct / 100,
                  minHeight: 6,
                  backgroundColor: cs.surface,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ),
        children: [
          _statRow(
            context,
            label: l10n.bucketListStatUs,
            value: metrics.usExploredPercent,
            subtitle: l10n.bucketListStatSubtitle(
              metrics.uniqueUsStatesVisited,
              TravelExplorationMetrics.kUsStateDenominator,
            ),
          ),
          const SizedBox(height: 10),
          _statRow(
            context,
            label: l10n.bucketListStatUsTerritories,
            value: metrics.usTerritoriesExploredPercent,
            subtitle: l10n.bucketListStatSubtitle(
              metrics.uniqueUsTerritoriesVisited,
              TravelExplorationMetrics.kUsTerritoryDenominator,
            ),
          ),
          const SizedBox(height: 10),
          _statRow(
            context,
            label: l10n.bucketListStatEurope,
            value: metrics.europeExploredPercent,
            subtitle: l10n.bucketListStatSubtitle(
              metrics.uniqueEuropeanCountriesVisited,
              TravelExplorationMetrics.kEuropeCountryDenominator,
            ),
          ),
          const SizedBox(height: 10),
          _statRow(
            context,
            label: l10n.bucketListStatAsia,
            value: metrics.asiaExploredPercent,
            subtitle: l10n.bucketListStatSubtitle(
              metrics.uniqueAsianCountriesVisited,
              TravelExplorationMetrics.kAsiaCountryDenominator,
            ),
          ),
          const SizedBox(height: 10),
          _statRow(
            context,
            label: l10n.bucketListStatAfrica,
            value: metrics.africaExploredPercent,
            subtitle: l10n.bucketListStatSubtitle(
              metrics.uniqueAfricanCountriesVisited,
              TravelExplorationMetrics.kAfricaCountryDenominator,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(
    BuildContext context, {
    required String label,
    required double value,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accentText = AppColors.accentOnSurface(theme.brightness);
    final pct = value.clamp(0, 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${pct.toStringAsFixed(1)}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: accentText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct / 100,
            minHeight: 6,
            backgroundColor: cs.surface,
            color: accentText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _BucketListList extends StatelessWidget {
  const _BucketListList({
    required this.destinations,
    required this.onEdit,
    required this.onDismissed,
    required this.allowEditing,
  });

  final List<TravelDestination> destinations;
  final void Function(TravelDestination d) onEdit;
  final void Function(String id) onDismissed;

  /// When false (free user), rows are read-only (no edit / swipe-delete).
  final bool allowEditing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
      children: [
        for (final cat in TravelDestinationCategory.values) ...[
          ..._buildCategorySection(context, l10n, cat, destinations),
        ],
      ],
    );
  }

  List<Widget> _buildCategorySection(
    BuildContext context,
    AppLocalizations l10n,
    TravelDestinationCategory cat,
    List<TravelDestination> all,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final accentText = AppColors.accentOnSurface(theme.brightness);
    final items = all.where((e) => e.category == cat).toList(growable: false);
    if (items.isEmpty) return [];

    return [
      Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                categoryLabel(l10n, cat).toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                ),
              ),
            ),
            if (allowEditing)
              Text(
                l10n.bucketListTapEditHint,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
      if (allowEditing)
        Text(
          l10n.bucketListDeleteHint,
          style: theme.textTheme.labelSmall?.copyWith(
            color: cs.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      if (allowEditing) const SizedBox(height: 6),
      ...items.map((d) {
        final tile = Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outline.withValues(alpha: 0.45)),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              leading: Icon(
                Icons.place_rounded,
                color: Color(_markerArgb(d.category)),
              ),
              title: Text(
                d.displayName,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: d.isUpcoming &&
                      d.startDate != null &&
                      d.endDate != null
                  ? Text(
                      formatBucketListTripDateRange(
                        d.startDate!.toLocal(),
                        d.endDate!.toLocal(),
                        Localizations.localeOf(context).toLanguageTag(),
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    )
                  : null,
              trailing: allowEditing
                  ? IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      color: accentText,
                      onPressed: () => onEdit(d),
                    )
                  : null,
              onTap: allowEditing ? () => onEdit(d) : null,
            ),
          );
        if (!allowEditing) {
          return tile;
        }
        return Dismissible(
          key: ValueKey<String>(d.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 18),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade900.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
          ),
          onDismissed: (_) => onDismissed(d.id),
          child: tile,
        );
      }),
    ];
  }
}

class _BucketListMap extends StatefulWidget {
  const _BucketListMap({
    required this.destinations,
    required this.styleUri,
    required this.token,
    required this.screenshotController,
    required this.overlayScreenshotController,
    required this.snapshotBridge,
    required this.onMarkerTap,
    this.showLegend = true,
    this.useSimpleGlassForExport = false,
  });

  final List<TravelDestination> destinations;
  final String styleUri;
  final String token;
  final ScreenshotController screenshotController;
  final ScreenshotController overlayScreenshotController;
  final BucketListMapSnapshotBridge snapshotBridge;
  final void Function(TravelDestination d) onMarkerTap;

  /// Hide the "Tap a marker for details" banner during share image capture.
  final bool showLegend;

  /// Avoid [BackdropFilter] during export — it does not layer correctly for
  /// overlay-only captures used on iOS with [MapboxMap.snapshot].
  final bool useSimpleGlassForExport;

  @override
  State<_BucketListMap> createState() => _BucketListMapState();
}

class _BucketListMapState extends State<_BucketListMap> {
  bool _mapboxReady = false;
  bool _styleLoadedForMap = false;
  MapboxMap? _map;
  PointAnnotationManager? _pointManager;
  Cancelable? _tapCancel;

  static const String _countryBoundariesSourceId = 'country-boundaries';
  static const String _countryBoundariesTilesetUrl =
      'mapbox://mapbox.country-boundaries-v1';
  static const String _countryBoundariesVectorLayerId = 'country_boundaries';
  static const String _countryChoroplethLayerId =
      'bucket-list-country-choropleth';

  @override
  void initState() {
    super.initState();
    unawaited(_initMapbox());
  }

  Future<void> _initMapbox() async {
    MapboxOptions.setAccessToken(widget.token);
    if (!mounted) return;
    setState(() => _mapboxReady = true);
  }

  @override
  void dispose() {
    _styleLoadedForMap = false;
    widget.snapshotBridge.snapshot = null;
    _tapCancel?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _BucketListMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.styleUri != widget.styleUri) {
      _styleLoadedForMap = false;
      _pointManager = null;
      _map = null;
      _tapCancel?.cancel();
      _tapCancel = null;
    }
    if (oldWidget.destinations != widget.destinations && _map != null) {
      unawaited(_loadAnnotations(_map!));
    }
  }

  Future<void> _configureFlatMap(MapboxMap map) async {
    try {
      await map.style.setProjection(
        StyleProjection(name: StyleProjectionName.mercator),
      );
    } catch (_) {}

    try {
      await map.gestures.updateSettings(
        GesturesSettings(
          rotateEnabled: false,
          pitchEnabled: false,
          simultaneousRotateAndPinchToZoomEnabled: false,
        ),
      );
    } catch (_) {}

    try {
      await map.logo.updateSettings(LogoSettings(enabled: false));
    } catch (_) {}
    try {
      await map.attribution.updateSettings(
        AttributionSettings(enabled: false, clickable: false),
      );
    } catch (_) {}
    try {
      await map.compass.updateSettings(CompassSettings(enabled: false));
    } catch (_) {}
    try {
      await map.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    } catch (_) {}

    widget.snapshotBridge.snapshot = () => map.snapshot();
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    await _configureFlatMap(map);
  }

  Future<void> _onStyleLoaded(MapboxMap map) async {
    _styleLoadedForMap = true;
    await _configureFlatMap(map);
    await _loadAnnotations(map);
  }

  Future<void> _syncCountryCategoryChoropleth(MapboxMap map) async {
    if (!_styleLoadedForMap) return;

    final fillExpr =
        buildBucketListCountryFillColorExpression(widget.destinations);

    try {
      final style = map.style;
      final srcExists =
          await style.styleSourceExists(_countryBoundariesSourceId);
      if (!srcExists) {
        await style.addSource(
          VectorSource(
            id: _countryBoundariesSourceId,
            url: _countryBoundariesTilesetUrl,
          ),
        );
      }

      final layer = FillLayer(
        id: _countryChoroplethLayerId,
        sourceId: _countryBoundariesSourceId,
        sourceLayer: _countryBoundariesVectorLayerId,
        fillColorExpression: fillExpr,
        fillOpacity: 0.55,
      );

      final layerExists =
          await style.styleLayerExists(_countryChoroplethLayerId);
      if (layerExists) {
        await style.updateLayer(layer);
      } else {
        await style.addLayer(layer);
      }
    } catch (e, st) {
      debugPrint('Bucket list choropleth: $e\n$st');
    }
  }

  Future<void> _loadAnnotations(MapboxMap map) async {
    final list = _destinationsOnMap(widget.destinations);
    _pointManager ??= await map.annotations.createPointAnnotationManager();
    final mgr = _pointManager!;
    await mgr.deleteAll();
    await mgr.setTextAllowOverlap(true);
    await mgr.setIconAllowOverlap(true);

    _tapCancel?.cancel();
    _tapCancel = mgr.tapEvents(
      onTap: (PointAnnotation ann) {
        final raw = ann.customData?['destinationId'];
        if (raw is! String) return;
        for (final d in list) {
          if (d.id == raw) {
            widget.onMarkerTap(d);
            return;
          }
        }
      },
    );

    final options = <PointAnnotationOptions>[];
    for (final d in list) {
      options.add(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(d.longitude, d.latitude),
          ),
          iconImage: 'circle-15',
          iconSize: 1.5,
          iconColor: _markerArgb(d.category),
          symbolSortKey: _symbolSortKey(d.category),
          customData: <String, Object>{'destinationId': d.id},
        ),
      );
    }
    if (options.isNotEmpty) {
      await mgr.createMulti(options);
    }
    await _syncCountryCategoryChoropleth(map);
    await _fitCamera(map, list);
  }

  Future<void> _fitCamera(MapboxMap map, List<TravelDestination> list) async {
    if (list.isEmpty) return;
    var minLng = double.infinity;
    var maxLng = double.negativeInfinity;
    var minLat = double.infinity;
    var maxLat = double.negativeInfinity;
    for (final d in list) {
      if (d.longitude < minLng) minLng = d.longitude;
      if (d.longitude > maxLng) maxLng = d.longitude;
      if (d.latitude < minLat) minLat = d.latitude;
      if (d.latitude > maxLat) maxLat = d.latitude;
    }
    if (!minLng.isFinite || !maxLng.isFinite) return;

    final lngSpan = maxLng - minLng;
    final latSpan = maxLat - minLat;
    // Hemisphere-spanning visits (e.g. America + Asia) make
    // `cameraForCoordinateBounds` over-zoom or fail across the antimeridian.
    // Fall back to a global view so the user always sees every visited country.
    if (lngSpan > 120 || latSpan > 100) {
      await map.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(0, 20)),
          zoom: 1.0,
          bearing: 0,
          pitch: 0,
        ),
        MapAnimationOptions(duration: 700),
      );
      return;
    }

    final bounds = CoordinateBounds(
      southwest: Point(coordinates: Position(minLng, minLat)),
      northeast: Point(coordinates: Position(maxLng, maxLat)),
      infiniteBounds: false,
    );
    try {
      final camera = await map.cameraForCoordinateBounds(
        bounds,
        MbxEdgeInsets(top: 96, left: 40, bottom: 160, right: 40),
        0,
        0,
        null,
        null,
      );
      await map.flyTo(camera, MapAnimationOptions(duration: 700));
    } catch (_) {
      final midLng = (minLng + maxLng) / 2;
      final midLat = (minLat + maxLat) / 2;
      await map.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(midLng, midLat)),
          zoom: 2,
          bearing: 0,
          pitch: 0,
        ),
        MapAnimationOptions(duration: 700),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (!_mapboxReady) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (Platform.isIOS)
          Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned.fill(
                child: MapWidget(
                  key: ValueKey(widget.styleUri),
                  styleUri: widget.styleUri,
                  // ignore: deprecated_member_use — Mapbox SDK; migrate when viewport API is adopted project-wide.
                  cameraOptions: CameraOptions(
                    center: Point(coordinates: Position(0, 20)),
                    zoom: 1.2,
                    bearing: 0,
                    pitch: 0,
                  ),
                  onMapCreated: (map) {
                    unawaited(_onMapCreated(map));
                  },
                  onStyleLoadedListener: (_) {
                    final m = _map;
                    if (m != null) unawaited(_onStyleLoaded(m));
                  },
                ),
              ),
              Positioned.fill(
                child: Screenshot(
                  controller: widget.overlayScreenshotController,
                  child: RepaintBoundary(
                    child: _BucketListMapShareOverlays(
                      useSimpleGlassForExport: widget.useSimpleGlassForExport,
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Screenshot(
            controller: widget.screenshotController,
            child: RepaintBoundary(
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: MapWidget(
                      key: ValueKey(widget.styleUri),
                      styleUri: widget.styleUri,
                      // ignore: deprecated_member_use — Mapbox SDK; migrate when viewport API is adopted project-wide.
                      cameraOptions: CameraOptions(
                        center: Point(coordinates: Position(0, 20)),
                        zoom: 1.2,
                        bearing: 0,
                        pitch: 0,
                      ),
                      onMapCreated: (map) {
                        unawaited(_onMapCreated(map));
                      },
                      onStyleLoadedListener: (_) {
                        final m = _map;
                        if (m != null) unawaited(_onStyleLoaded(m));
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: _BucketListMapShareOverlays(
                      useSimpleGlassForExport: widget.useSimpleGlassForExport,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (widget.showLegend)
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Builder(
              builder: (context) {
                final cs = Theme.of(context).colorScheme;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: cs.surface.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: cs.outline.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.bucketListMapLegend,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: cs.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Share stats + watermarks; non-interactive so gestures reach the map.
/// Captured by [Screenshot] / [RepaintBoundary] when sharing.
class _BucketListMapShareOverlays extends ConsumerWidget {
  const _BucketListMapShareOverlays({this.useSimpleGlassForExport = false});

  final bool useSimpleGlassForExport;

  static const _gold = Color(0xFFE6C35C);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final list =
        ref.watch(bucketListProvider).value ?? const <TravelDestination>[];
    final metrics = TravelExplorationMetrics.fromDestinations(list);
    final visitedCountries = metrics.uniqueCountriesVisited;
    final visitedCities = _shareMapUniqueVisitedCityCount(list);
    final worldPct = metrics.worldExploredPercent.toStringAsFixed(1);
    final populationPct = _shareMapPopulationComparePercent(visitedCountries);
    // Watch the reactive Firebase user so a fresh display name (saved in
    // [AccountManagementScreen]) is baked into the share watermark without
    // requiring an app restart.
    final authUser = ref.watch(firebaseAuthUserProvider).valueOrNull;
    final displayName = _shareMapDisplayName(authUser);

    final framedStats = DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xD9000000),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _gold.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.bucketListShareMapStatExplore(
                displayName,
                worldPct,
                populationPct,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.92),
                height: 1.25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ShareStatNumber(
                    value: '$visitedCountries',
                    caption: l10n.bucketListShareMapCountriesLabel,
                  ),
                ),
                Container(
                  width: 1,
                  height: 44,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _ShareStatNumber(
                    value: '$visitedCities',
                    caption: l10n.bucketListShareMapCitiesLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.bucketListShareMapWatermarkUrl,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.65),
                letterSpacing: 0.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );

    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 28,
            left: 0,
            right: 0,
            child: Center(
              child: Opacity(
                opacity: 0.2,
                child: Text(
                  l10n.bucketListShareMapWatermarkLarge,
                  style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        shadows: const [
                          Shadow(
                            blurRadius: 8,
                            color: Color(0x88000000),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ) ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        letterSpacing: 4,
                      ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: useSimpleGlassForExport
                  ? framedStats
                  : BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: framedStats,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareStatNumber extends StatelessWidget {
  const _ShareStatNumber({
    required this.value,
    required this.caption,
  });

  final String value;
  final String caption;

  static const _gold = Color(0xFFE6C35C);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
                  color: _gold,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                  shadows: const [
                    Shadow(
                      blurRadius: 6,
                      color: Color(0x66000000),
                      offset: Offset(0, 1),
                    ),
                  ],
                ) ??
                const TextStyle(
                  color: _gold,
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
