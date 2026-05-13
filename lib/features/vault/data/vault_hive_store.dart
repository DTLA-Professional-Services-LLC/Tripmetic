import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;

import '../domain/vault_document.dart';

const _kBoxName = 'tripmetic_vault';
const _kDocumentsKey = 'vault_documents_v1';

const _kVaultDemoSeed = 'tripmetic_vault_demo_v1';

/// Minimal 1×1 PNG for sample vault thumbnails.
final List<int> _kVaultDemoPngBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAmmqWQgAAAABJRU5ErkJggg==',
);

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

  /// First launch only: a few tiny PNG “documents” so tiles show how the vault works.
  Future<void> applyDemoSeedsIfNeeded(String appDocumentsPath) async {
    if (_requireBox.get(_kVaultDemoSeed) == true) return;
    try {
      if (_requireBox.containsKey(_kDocumentsKey)) return;

      Future<VaultDocument> write(String slug, String category) async {
        final fileName = 'tripmetic_demo_${slug}_sample.png';
        final fullPath = p.join(appDocumentsPath, fileName);
        await File(fullPath).writeAsBytes(_kVaultDemoPngBytes, flush: true);
        return VaultDocument(
          id: fileName,
          category: category,
          localPath: fullPath,
          isPdf: false,
          createdAt: DateTime.now(),
        );
      }

      final docs = await Future.wait([
        write('passport', 'Passport Copy'),
        write('hotel', 'Hotel Reservation'),
        write('visa', 'Visa'),
      ]);
      await saveDocuments(docs);
    } finally {
      await _requireBox.put(_kVaultDemoSeed, true);
    }
  }
}
