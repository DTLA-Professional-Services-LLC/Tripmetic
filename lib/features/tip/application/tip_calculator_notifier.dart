import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tip_calculator_state.dart';

class TipCalculatorNotifier extends Notifier<TipCalculatorState> {
  @override
  TipCalculatorState build() => TipCalculatorState.initial();

  void setCountry(TipCountry country) {
    state = state.copyWith(
      country: country,
      tipPercent: country.defaultTipPercent,
    );
  }

  void setBillAmount(double value) {
    state = state.copyWith(billAmount: value < 0 ? 0 : value);
  }

  void setTipPercent(double value) {
    final v = value.clamp(0.0, 100.0);
    state = state.copyWith(tipPercent: v);
  }

  void setPeople(int value) {
    final v = value.clamp(1, 20);
    state = state.copyWith(people: v);
  }
}

final tipCalculatorProvider =
    NotifierProvider<TipCalculatorNotifier, TipCalculatorState>(TipCalculatorNotifier.new);
