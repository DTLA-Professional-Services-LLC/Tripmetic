import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bottom shell selection: indices `0`–`3` are the pinned tool slots; `4` is More.
///
/// Single source of truth for [MainScreen] tab selection (unidirectional flow).
final currentTabIndexProvider = StateProvider<int>((ref) => 0);
