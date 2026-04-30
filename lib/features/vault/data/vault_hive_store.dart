import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../domain/vault_document.dart';

const _kBoxName = 'tripmetic_vault';
const _kDocumentsKey = 'vault_documents_v1';

class VaultHiveStore {
  Box<dynamic>? _box;

  Future<void> open() async {
    _box = await Hive.openBox<dynamic>(_kBoxName);
  }

  Box<dynamic> get _requireBox {
    final b = _box;
    if (b == null) {
      throw StateError('VaultHiveStore.open() must be called before use');
    }
    return b;
  }

  List<VaultDocument> loadDocuments() {
    final raw = _requireBox.get(_kDocumentsKey);
    if (raw is String && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((dynamic e) {
              if (e is! Map) return null;
              return VaultDocument.fromJson(Map<dynamic, dynamic>.from(e));
            })
            .whereType<VaultDocument>()
            .toList();
      } catch (_) {
        return [];
      }
    }
    if (raw is List) {
      return raw
          .map((dynamic e) {
            if (e is! Map) return null;
            return VaultDocument.fromJson(Map<dynamic, dynamic>.from(e));
          })
          .whereType<VaultDocument>()
          .toList();
    }
    return [];
  }

  Future<void> saveDocuments(List<VaultDocument> documents) async {
    await _requireBox.put(
      _kDocumentsKey,
      jsonEncode(documents.map((e) => e.toJson()).toList()),
    );
    await _requireBox.flush();
  }
}
