class VaultDocument {
  final String id;
  final String category;
  final String localPath;
  final bool isPdf;
  final DateTime createdAt;

  VaultDocument({
    required this.id,
    required this.category,
    required this.localPath,
    required this.isPdf,
    required this.createdAt,
  });

  VaultDocument copyWith({
    String? id,
    String? category,
    String? localPath,
    bool? isPdf,
    DateTime? createdAt,
  }) {
    return VaultDocument(
      id: id ?? this.id,
      category: category ?? this.category,
      localPath: localPath ?? this.localPath,
      isPdf: isPdf ?? this.isPdf,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'localPath': localPath,
      'isPdf': isPdf,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory VaultDocument.fromJson(Map<dynamic, dynamic> json) {
    return VaultDocument(
      id: json['id'] as String,
      category: json['category'] as String,
      localPath: json['localPath'] as String,
      isPdf: json['isPdf'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
