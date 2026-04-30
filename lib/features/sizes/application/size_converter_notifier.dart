import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/country_sizing_generated.dart';
import '../domain/size_conversion_data.dart';
import '../domain/size_lookup.dart';

class SizeConverterState {
  const SizeConverterState({
    required this.category,
    required this.countryAlpha2,
    required this.baseSizeInput,
  });

  final SizeCategory category;
  final String countryAlpha2;
  final String baseSizeInput;

  CountrySizingEntry? get countryEntry =>
      countrySizingEntryByAlpha2(countryAlpha2);

  SizeRow? get resolvedRow {
    final entry = countryEntry;
    if (entry == null) return null;
    return lookupSizeRow(
      category: category,
      primary: entry.primaryColumn,
      rawInput: baseSizeInput,
    );
  }

  SizeConverterState copyWith({
    SizeCategory? category,
    String? countryAlpha2,
    String? baseSizeInput,
  }) {
    return SizeConverterState(
      category: category ?? this.category,
      countryAlpha2: countryAlpha2 ?? this.countryAlpha2,
      baseSizeInput: baseSizeInput ?? this.baseSizeInput,
    );
  }

  static String defaultSizeHint(SizeCategory c) {
    return switch (c) {
      SizeCategory.mensShoes => '9',
      SizeCategory.womensShoes => '8',
      SizeCategory.womensDresses => '8',
      SizeCategory.mensShirts => '15',
      SizeCategory.mensPants => '32',
      SizeCategory.womensPants => '8',
      SizeCategory.womensBlouses => '8',
      SizeCategory.mensTshirts => 'M',
      SizeCategory.womensTshirts => 'M',
      SizeCategory.mensJeansWaist => '38',
      SizeCategory.mensJeansInseam => '32',
      SizeCategory.mensJeansCombo => '38x32',
      SizeCategory.belts => '34',
    };
  }

  static SizeConverterState initial() {
    return SizeConverterState(
      category: SizeCategory.mensShoes,
      countryAlpha2: 'US',
      baseSizeInput: defaultSizeHint(SizeCategory.mensShoes),
    );
  }
}

class SizeConverterNotifier extends Notifier<SizeConverterState> {
  @override
  SizeConverterState build() => SizeConverterState.initial();

  void setCategory(SizeCategory category) {
    state = SizeConverterState(
      category: category,
      countryAlpha2: state.countryAlpha2,
      baseSizeInput: SizeConverterState.defaultSizeHint(category),
    );
  }

  void setCountry(String alpha2) {
    state = state.copyWith(countryAlpha2: alpha2.toUpperCase());
  }

  void setBaseSizeInput(String text) {
    state = state.copyWith(baseSizeInput: text);
  }
}

final sizeConverterProvider =
    NotifierProvider<SizeConverterNotifier, SizeConverterState>(
      SizeConverterNotifier.new,
    );
