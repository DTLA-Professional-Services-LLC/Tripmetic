import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mind_map_hive_store.dart';
import '../domain/mind_map_document.dart';
import '../domain/mind_map_layout.dart';
import '../domain/mind_map_node.dart';

final mindMapHiveStoreProvider = Provider<MindMapHiveStore>((ref) {
  return MindMapHiveStore();
});

final mindMapHiveStoreReadyProvider = FutureProvider<void>((ref) async {
  await ref.read(mindMapHiveStoreProvider).open();
});

final mindMapProvider = NotifierProvider<MindMapNotifier, MindMapDocument>(MindMapNotifier.new);

class MindMapNotifier extends Notifier<MindMapDocument> {
  MindMapHiveStore get _store => ref.read(mindMapHiveStoreProvider);
  Timer? _debounce;

  @override
  MindMapDocument build() {
    ref.onDispose(() => _debounce?.cancel());
    final ready = ref.watch(mindMapHiveStoreReadyProvider);
    // Hive is opened in main() before runApp; avoid a transient branch that could
    // flash the wrong document. Until ready, show the same 4-node demo as load().
    if (!ready.hasValue) {
      return MindMapDocument.demo();
    }
    return _store.load();
  }

  void _schedulePersist() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      unawaited(_store.save(state));
    });
  }

  void selectNode(String? id) {
    state = state.withActive(id);
  }

  void setNodeText(String id, String text) {
    final next = state.nodes.map((n) {
      if (n.id != id) return n;
      return MindMapNode(
        id: n.id,
        text: text,
        x: n.x,
        y: n.y,
        parentId: n.parentId,
      );
    }).toList();
    state = state.withNodes(next);
    _schedulePersist();
  }

  void moveNode(String id, double dx, double dy) {
    final next = state.nodes.map((n) {
      if (n.id != id) return n;
      return MindMapNode(
        id: n.id,
        text: n.text,
        x: n.x + dx,
        y: n.y + dy,
        parentId: n.parentId,
      );
    }).toList();
    state = state.withNodes(next);
    _schedulePersist();
  }

  void bringToFront(String id) {
    final idx = state.nodes.indexWhere((n) => n.id == id);
    if (idx < 0 || idx >= state.nodes.length) return;
    final n = state.nodes[idx];
    final rest = [...state.nodes.sublist(0, idx), ...state.nodes.sublist(idx + 1)];
    state = state.withNodes([...rest, n]);
    _schedulePersist();
  }

  void addChildTo(String parentId, {bool isLeft = false}) {
    final parent = state.getNode(parentId);
    if (parent == null) return;

    final existingChildren = state.nodes.where((n) => n.parentId == parentId).length;
    final childId = mindMapNewNodeId();
    
    final double dirX = isLeft ? -1.0 : 1.0;
    
    final child = MindMapNode(
      id: childId,
      text: 'New Idea',
      x: parent.x +
          (MindMapLayout.newChildOffsetX * dirX) +
          (existingChildren * 10 * dirX),
      y: parent.y +
          MindMapLayout.newChildOffsetY +
          existingChildren * 20,
      parentId: parentId,
    );
    state = MindMapDocument(
      nodes: [...state.nodes, child],
      activeNodeId: childId,
    );
    _schedulePersist();
  }

  /// Removes [id] and all descendant nodes; clears selection if it pointed at a removed id.
  void deleteNode(String id) {
    final target = state.getNode(id);
    if (target == null || target.parentId == null) return;

    final toRemove = <String>{};
    void collect(String nid) {
      if (toRemove.contains(nid)) return;
      toRemove.add(nid);
      for (final n in state.nodes) {
        if (n.parentId == nid) collect(n.id);
      }
    }

    collect(id);

    final next = state.nodes.where((n) => !toRemove.contains(n.id)).toList();
    var nextActive = state.activeNodeId;
    if (nextActive != null && toRemove.contains(nextActive)) {
      nextActive = target.parentId;
      final stillHas = nextActive != null && next.any((n) => n.id == nextActive);
      if (!stillHas) {
        nextActive = next.isNotEmpty ? next.first.id : null;
      }
    }
    state = MindMapDocument(nodes: next, activeNodeId: nextActive);
    _schedulePersist();
  }

  void resetCanvas() {
    state = MindMapDocument.demo();
    unawaited(_store.save(state));
  }
}
