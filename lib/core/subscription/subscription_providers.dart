import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'tripmetic_pro_entitlement.dart';

const Duration _kCustomerInfoTimeout = Duration(seconds: 12);

/// Latest [CustomerInfo]; updates when purchases restore or renew.
/// [Purchases.configure] runs in `main()` before [runApp].
final customerInfoProvider = AsyncNotifierProvider<CustomerInfoNotifier, CustomerInfo>(
  CustomerInfoNotifier.new,
);

class CustomerInfoNotifier extends AsyncNotifier<CustomerInfo> {
  CustomerInfoUpdateListener? _listener;

  @override
  Future<CustomerInfo> build() async {
    ref.onDispose(_teardown);

    final initial = await Purchases.getCustomerInfo().timeout(_kCustomerInfoTimeout);
    _listener = (CustomerInfo info) {
      state = AsyncData(info);
    };
    Purchases.addCustomerInfoUpdateListener(_listener!);
    return initial;
  }

  void _teardown() {
    if (_listener != null) {
      Purchases.removeCustomerInfoUpdateListener(_listener!);
      _listener = null;
    }
  }

  /// Force-refresh from RevenueCat servers (e.g. after login).
  Future<void> sync() async {
    try {
      state = const AsyncLoading();
      final info = await Purchases.getCustomerInfo().timeout(_kCustomerInfoTimeout);
      state = AsyncData(info);
    } catch (e, st) {
      assert(() {
        debugPrint('sync customer info failed: $e\n$st');
        return true;
      }());
      state = AsyncError(e, st);
    }
  }
}

/// `true` when the **Tripmetic Pro** entitlement is active.
final isTripmeticProProvider = Provider<bool>((ref) {
  final async = ref.watch(customerInfoProvider);
  return async.maybeWhen(
    data: (info) => TripmeticProEntitlement.isUnlocked(info),
    orElse: () => false,
  );
});
