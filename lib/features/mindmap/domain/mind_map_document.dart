import 'dart:math';

import 'mind_map_layout.dart';
import 'mind_map_node.dart';

String mindMapNewNodeId() =>
    'mm_${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 30)}';

/// Serializable mind map snapshot for Hive and providers.
class MindMapDocument {
  const MindMapDocument({
    required this.nodes,
    this.activeNodeId,
  });

  final List<MindMapNode> nodes;
  final String? activeNodeId;

  MindMapDocument withNodes(List<MindMapNode> newNodes) {
    return MindMapDocument(nodes: newNodes, activeNodeId: activeNodeId);
  }

  MindMapDocument withActive(String? activeNodeId) {
    return MindMapDocument(nodes: nodes, activeNodeId: activeNodeId);
  }

  Map<String, dynamic> toJson() => {
        'nodes': nodes.map((e) => e.toJson()).toList(),
        'activeNodeId': activeNodeId,
      };

  factory MindMapDocument.fromJson(Map<dynamic, dynamic> m) {
    final raw = m['nodes'];
    final list = <MindMapNode>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map) {
          list.add(MindMapNode.fromJson(Map<dynamic, dynamic>.from(e)));
        }
      }
    }
    return MindMapDocument(
      nodes: list,
      activeNodeId: m['activeNodeId'] as String?,
    );
  }

  factory MindMapDocument.initial() {
    final rootId = mindMapNewNodeId();
    return MindMapDocument(
      nodes: [
        MindMapNode(
          id: rootId,
          text: 'New Idea',
          x: MindMapLayout.rootTopLeftX,
          y: MindMapLayout.rootTopLeftY,
          parentId: null,
        ),
      ],
      activeNodeId: rootId,
    );
  }

  /// First-time / empty-storage experience: visible cluster around canvas center.
  factory MindMapDocument.demo() {
    const rootId = 'mm_demo_root';
    const audienceId = 'mm_demo_audience';
    const revenueId = 'mm_demo_revenue';
    const marketingId = 'mm_demo_marketing';
    final rx = MindMapLayout.rootTopLeftX;
    final ry = MindMapLayout.rootTopLeftY;
    return MindMapDocument(
      nodes: [
        MindMapNode(
          id: rootId,
          text: 'New Business Idea',
          x: rx,
          y: ry,
          parentId: null,
        ),
        MindMapNode(
          id: audienceId,
          text: 'Target Audience',
          x: rx + 240,
          y: ry - 96,
          parentId: rootId,
        ),
        MindMapNode(
          id: revenueId,
          text: 'Revenue Model',
          x: rx + 268,
          y: ry + 108,
          parentId: rootId,
        ),
        MindMapNode(
          id: marketingId,
          text: 'Marketing Strategy',
          x: rx - 288,
          y: ry,
          parentId: rootId,
        ),
      ],
      activeNodeId: rootId,
    );
  }

  MindMapNode? getNode(String id) {
    for (final n in nodes) {
      if (n.id == id) return n;
    }
    return null;
  }
}
