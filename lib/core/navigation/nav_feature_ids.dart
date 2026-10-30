import 'package:flutter/material.dart';

/// Stable ids for bottom pins and the More menu (persisted in SharedPreferences).
abstract final class NavFeatureIds {
  static const String dashboard = 'dashboard';
  static const String itinerary = 'itinerary';
  static const String currency = 'currency';
  static const String offlineMap = 'offline_map';
  static const String bucketList = 'bucket_list';
  static const String groupPlanner = 'group_planner';
  static const String budget = 'budget';
  static const String vault = 'vault';
  static const String scheduler = 'scheduler';
  static const String packing = 'packing';
  static const String units = 'units';
  static const String crypto = 'crypto';
  static const String tipCalculator = 'tip_calculator';
  static const String sizeConverter = 'size_converter';
  static const String mindMap = 'mind_map';
  static const String dualClock = 'dual_clock';
  static const String settings = 'settings';

  static const List<String> defaultPinned = [
    dashboard,
    dualClock,
    units,
    settings,
  ];

  static const List<String> pinnableIds = [
    dashboard,
    itinerary,
    currency,
    offlineMap,
    bucketList,
    groupPlanner,
    budget,
    vault,
    scheduler,
    packing,
    units,
    crypto,
    tipCalculator,
    sizeConverter,
    mindMap,
    dualClock,
    settings,
  ];

  static Set<String> get pinnableIdSet => pinnableIds.toSet();

  static List<String> get moreMenuIds => List<String>.unmodifiable(pinnableIds);
}

/// Route used when opening a feature from the More menu (GoRouter push).
abstract final class NavFeatureRoutes {
  static const Map<String, String> pathById = {
    NavFeatureIds.itinerary: '/itinerary',
    NavFeatureIds.currency: '/currency',
    NavFeatureIds.offlineMap: '/offline-map',
    NavFeatureIds.bucketList: '/bucket-list',
    NavFeatureIds.groupPlanner: '/group-planner',
    NavFeatureIds.budget: '/budget',
    NavFeatureIds.vault: '/vault',
    NavFeatureIds.scheduler: '/scheduler',
    NavFeatureIds.packing: '/packing',
    NavFeatureIds.units: '/units',
    NavFeatureIds.crypto: '/crypto',
    NavFeatureIds.tipCalculator: '/tip-calculator',
    NavFeatureIds.sizeConverter: '/size-converter',
    NavFeatureIds.mindMap: '/mind-map',
    NavFeatureIds.dualClock: '/dual-clock-widget',
    NavFeatureIds.settings: '/settings',
  };

  static String? routeFor(String id) => pathById[id];

  static String? idForPath(String path) {
    for (final e in pathById.entries) {
      if (e.value == path) return e.key;
    }
    return null;
  }

  /// Included without Tripmetic Pro: home dashboard, settings, units, dual clock.
  /// The in-app currency converter is Pro; the Android home-screen widget is free
  /// via dedicated `/currency-widget/*` routes (not this list).
  static const Set<String> freeFeatureIds = {
    NavFeatureIds.dashboard,
    NavFeatureIds.settings,
    NavFeatureIds.units,
    NavFeatureIds.dualClock,
  };

  static bool isFree(String id) => freeFeatureIds.contains(id);

  /// Whether this feature requires Pro to **use** (open / pinned tab body).
  static bool isPro(String id) => !isFree(id);
}

IconData navFeatureIcon(String id) => switch (id) {
      NavFeatureIds.dashboard => Icons.dashboard_outlined,
      NavFeatureIds.itinerary => Icons.route_outlined,
      NavFeatureIds.currency => Icons.currency_exchange_outlined,
      NavFeatureIds.offlineMap => Icons.map_outlined,
      NavFeatureIds.bucketList => Icons.star_border_rounded,
      NavFeatureIds.groupPlanner => Icons.groups_outlined,
      NavFeatureIds.budget => Icons.account_balance_wallet_outlined,
      NavFeatureIds.vault => Icons.folder_shared_outlined,
      NavFeatureIds.scheduler => Icons.schedule_rounded,
      NavFeatureIds.packing => Icons.luggage_outlined,
      NavFeatureIds.units => Icons.straighten_outlined,
      NavFeatureIds.crypto => Icons.currency_bitcoin_outlined,
      NavFeatureIds.tipCalculator => Icons.restaurant_rounded,
      NavFeatureIds.sizeConverter => Icons.checkroom_outlined,
      NavFeatureIds.mindMap => Icons.account_tree_outlined,
      NavFeatureIds.dualClock => Icons.watch_later_outlined,
      NavFeatureIds.settings => Icons.settings_outlined,
      _ => Icons.apps_outlined,
    };
