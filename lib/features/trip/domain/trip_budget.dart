/// Canonical expense category labels (map keys in [TripBudget.expenses]).
abstract final class TripBudgetExpenseKeys {
  static const dailyFood = 'Daily Food';

  static const List<String> all = [
    'Flights',
    'Hotels',
    'Transportation',
    dailyFood,
    'Shopping',
    'Eating Out',
    'Grocery',
    'Entertainment',
    'Tourism',
    'Phone Service',
    'Travel Insurance',
    'Misc',
  ];
}

/// Multi-destination trip budget. Amounts are in [baseCurrency].
/// [expenses] for [TripBudgetExpenseKeys.dailyFood] stores the **trip total** for food;
/// per-day = total / [tripDays] when [tripDays] > 0.
class TripBudget {
  const TripBudget({
    required this.totalBudget,
    required this.baseCurrency,
    required this.tripDays,
    required this.destinationCurrencies,
    required this.expenses,
  });

  final double totalBudget;
  final String baseCurrency;
  final int tripDays;
  final List<String> destinationCurrencies;
  final Map<String, double> expenses;

  factory TripBudget.initial() {
    final exp = {for (final k in TripBudgetExpenseKeys.all) k: 0.0};
    return TripBudget(
      totalBudget: 3000,
      baseCurrency: 'USD',
      tripDays: 7,
      destinationCurrencies: ['EUR', 'PHP'],
      expenses: exp,
    );
  }

  double get dailyFoodTotal => expenses[TripBudgetExpenseKeys.dailyFood] ?? 0;

  double get dailyFoodPerDay {
    final d = tripDays <= 0 ? 1 : tripDays;
    return dailyFoodTotal / d;
  }

  /// All category keys currently in use (hardcoded defaults + user-added).
  List<String> get categoryKeys {
    final keys = <String>[];
    // Preserve order: defaults first, then custom.
    for (final k in TripBudgetExpenseKeys.all) {
      if (expenses.containsKey(k)) keys.add(k);
    }
    for (final k in expenses.keys) {
      if (!keys.contains(k)) keys.add(k);
    }
    return keys;
  }

  double get totalSpent =>
      expenses.values.fold(0.0, (s, v) => s + v);

  double get remaining => (totalBudget - totalSpent).clamp(-double.maxFinite, double.maxFinite);

  TripBudget copyWith({
    double? totalBudget,
    String? baseCurrency,
    int? tripDays,
    List<String>? destinationCurrencies,
    Map<String, double>? expenses,
  }) {
    return TripBudget(
      totalBudget: totalBudget ?? this.totalBudget,
      baseCurrency: (baseCurrency ?? this.baseCurrency).toUpperCase(),
      tripDays: tripDays ?? this.tripDays,
      destinationCurrencies: destinationCurrencies ?? List<String>.from(this.destinationCurrencies),
      expenses: expenses ?? Map<String, double>.from(this.expenses),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalBudget': totalBudget,
        'baseCurrency': baseCurrency,
        'tripDays': tripDays,
        'destinationCurrencies': destinationCurrencies,
        'expenses': expenses,
      };

  static TripBudget fromJson(Map<dynamic, dynamic> json) {
    final rawExp = json['expenses'];
    final exp = <String, double>{};
    if (rawExp is Map) {
      for (final e in rawExp.entries) {
        final v = e.value;
        if (v is num) exp[e.key.toString()] = v.toDouble();
      }
    }
    // Ensure default categories exist (for fresh installs / upgrades).
    for (final k in TripBudgetExpenseKeys.all) {
      exp.putIfAbsent(k, () => 0);
    }
    final rawDest = json['destinationCurrencies'];
    final dest = <String>[];
    if (rawDest is List) {
      for (final e in rawDest) {
        final s = e.toString().trim().toUpperCase();
        if (s.length == 3) dest.add(s);
      }
    }
    final tb = json['totalBudget'];
    final bc = json['baseCurrency']?.toString().trim().toUpperCase();
    final td = json['tripDays'];
    final days = td is int
        ? td
        : td is num
            ? td.toInt()
            : int.tryParse(td?.toString() ?? '') ?? 7;

    return TripBudget(
      totalBudget: tb is num ? tb.toDouble() : 0,
      baseCurrency: (bc != null && bc.length == 3) ? bc : 'USD',
      tripDays: days.clamp(1, 3650),
      destinationCurrencies: dest.isEmpty ? TripBudget.initial().destinationCurrencies : dest,
      expenses: exp,
    );
  }
}
