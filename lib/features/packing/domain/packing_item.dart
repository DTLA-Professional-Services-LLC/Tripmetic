import 'dart:math';

import 'packing_category.dart';

/// One row in the packing / logistics checklist.
class PackingItem {
  const PackingItem({
    required this.id,
    required this.title,
    required this.category,
    required this.isCompleted,
    required this.quantity,
    required this.iconName,
  });

  final String id;
  final String title;
  final String category;
  final bool isCompleted;
  final int quantity;
  final String iconName;

  PackingItem copyWith({
    String? id,
    String? title,
    String? category,
    bool? isCompleted,
    int? quantity,
    String? iconName,
  }) {
    return PackingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      quantity: quantity ?? this.quantity,
      iconName: iconName ?? this.iconName,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'isCompleted': isCompleted,
        'quantity': quantity,
        'iconName': iconName,
      };

  static PackingItem? fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;
    final id = json['id']?.toString();
    if (id == null || id.isEmpty) return null;
    final title = (json['title']?.toString() ?? '').trim();
    if (title.isEmpty) return null;
    var category = json['category']?.toString() ?? PackingCategory.misc;
    if (!PackingCategory.isValid(category)) {
      category = PackingCategory.misc;
    }
    final completed = json['isCompleted'] == true;
    var qty = 1;
    final q = json['quantity'];
    if (q is int) {
      qty = q;
    } else if (q is num) {
      qty = q.round();
    }
    if (qty < 1) qty = 1;
    if (qty > 999) qty = 999;
    final icon = (json['iconName']?.toString() ?? 'luggage').trim();
    return PackingItem(
      id: id,
      title: title,
      category: category,
      isCompleted: completed,
      quantity: qty,
      iconName: icon.isEmpty ? 'luggage' : icon,
    );
  }

  static String newId() {
    return '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 30)}';
  }

  /// Shown on first launch when no packing data exists in Hive yet.
  static List<PackingItem> starterItems() => [
        PackingItem(
          id: '${newId()}_passport',
          title: 'Passport',
          category: PackingCategory.documents,
          isCompleted: false,
          quantity: 1,
          iconName: 'badge',
        ),
        PackingItem(
          id: '${newId()}_tickets',
          title: 'Flight tickets',
          category: PackingCategory.reservations,
          isCompleted: false,
          quantity: 1,
          iconName: 'flight',
        ),
        PackingItem(
          id: '${newId()}_socks',
          title: 'Socks',
          category: PackingCategory.clothing,
          isCompleted: false,
          quantity: 1,
          iconName: 'checkroom',
        ),
        PackingItem(
          id: '${newId()}_shirts',
          title: 'Shirts',
          category: PackingCategory.clothing,
          isCompleted: false,
          quantity: 1,
          iconName: 'checkroom',
        ),
        PackingItem(
          id: '${newId()}_toothbrush',
          title: 'Toothbrush',
          category: PackingCategory.misc,
          isCompleted: false,
          quantity: 1,
          iconName: 'hygiene',
        ),
      ];
}
