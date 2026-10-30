/// A single node in the brainstorming mind map.
class MindMapNode {
  MindMapNode({
    required this.id,
    required this.text,
    required this.x,
    required this.y,
    this.parentId,
  });

  final String id;
  String text;
  double x;
  double y;
  String? parentId;

  MindMapNode copyWith({
    String? id,
    String? text,
    double? x,
    double? y,
    String? parentId,
  }) {
    return MindMapNode(
      id: id ?? this.id,
      text: text ?? this.text,
      x: x ?? this.x,
      y: y ?? this.y,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'x': x,
        'y': y,
        'parentId': parentId,
      };

  factory MindMapNode.fromJson(Map<dynamic, dynamic> m) {
    return MindMapNode(
      id: m['id'] as String,
      text: m['text'] as String? ?? '',
      x: (m['x'] as num?)?.toDouble() ?? 0,
      y: (m['y'] as num?)?.toDouble() ?? 0,
      parentId: m['parentId'] as String?,
    );
  }
}
