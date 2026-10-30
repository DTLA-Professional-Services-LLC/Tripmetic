import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../domain/mind_map_document.dart';

const _kMindMapBoxName = 'tripmetic_mindmap';
const _kMindMapStateKey = 'mind_map_brainstorm_v1';

/// Offline persistence for the brainstorming mind map (JSON in Hive).
class MindMapHiveStore {
  Box<dynamic>? _box;

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kMindMapBoxName);
  }

  Box<dynamic> get _requireBox {
    final b = _box;
    if (b == null) {
      throw StateError('MindMapHiveStore.open() must be called before use');
    }
    return b;
  }

  MindMapDocument load() {
    final raw = _requireBox.get(_kMindMapStateKey);
    if (raw == null) {
      return MindMapDocument.demo();
    }
    if (raw is String && raw.isNotEmpty) {
      try {
        final map = jsonDecode(raw) as Map<dynamic, dynamic>;
        final doc = MindMapDocument.fromJson(map);
        if (doc.nodes.isEmpty) return MindMapDocument.demo();
        return doc;
      } catch (_) {
        /* fall through */
      }
    }
    if (raw is Map) {
      try {
        final doc = MindMapDocument.fromJson(Map<dynamic, dynamic>.from(raw));
        if (doc.nodes.isEmpty) return MindMapDocument.demo();
        return doc;
      } catch (_) {
        /* fall through */
      }
    }
    return MindMapDocument.demo();
  }

  Future<void> save(MindMapDocument doc) async {
    await _requireBox.put(_kMindMapStateKey, jsonEncode(doc.toJson()));
  }
}
