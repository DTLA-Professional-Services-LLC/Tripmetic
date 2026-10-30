import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../data/vault_hive_store.dart';
import '../domain/vault_document.dart';

final vaultHiveStoreProvider = Provider<VaultHiveStore>((ref) {
  return VaultHiveStore();
});

final vaultHiveStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.read(vaultHiveStoreProvider).open();
});

final vaultProvider = NotifierProvider<VaultNotifier, List<VaultDocument>>(VaultNotifier.new);

class VaultNotifier extends Notifier<List<VaultDocument>> {
  VaultHiveStore get _store => ref.read(vaultHiveStoreProvider);

  @override
  List<VaultDocument> build() {
    final ready = ref.watch(vaultHiveStoreReadyProvider);
    return ready.when(
      data: (_) => _store.loadDocuments(),
      loading: () => const [],
      error: (error, stack) => const [],
    );
  }

  Future<void> _persist() async {
    await _store.saveDocuments(state);
  }

  Future<void> pickAndSaveDocument(String category) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = File(result.files.single.path!);
    final extension = p.extension(file.path).toLowerCase();
    final isPdf = extension == '.pdf';

    final appDocDir = await getApplicationDocumentsDirectory();
    
    // Create a unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newFileName = 'vault_${category.replaceAll(' ', '_').toLowerCase()}_$timestamp$extension';
    final newPath = p.join(appDocDir.path, newFileName);

    // Copy the file to the app's document directory
    final savedFile = await file.copy(newPath);

    final newDoc = VaultDocument(
      id: newFileName,
      category: category,
      localPath: savedFile.path,
      isPdf: isPdf,
      createdAt: DateTime.now(),
    );

    // Remove any existing document in this category to overwrite
    final newState = state.where((doc) => doc.category != category).toList();
    newState.add(newDoc);
    
    state = newState;
    await _persist();
  }

  Future<void> deleteDocument(String category) async {
    final existingDoc = state.firstWhere((doc) => doc.category == category, orElse: () => VaultDocument(id: '', category: '', localPath: '', isPdf: false, createdAt: DateTime.now()));
    
    if (existingDoc.id.isNotEmpty) {
      try {
        final file = File(existingDoc.localPath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Ignore file deletion errors
      }
    }

    state = state.where((doc) => doc.category != category).toList();
    await _persist();
  }
}
