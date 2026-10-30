import 'package:flutter/material.dart';

/// Maps persisted [PackingItem.iconName] keys to [IconData].
IconData packingIconForName(String name) {
  return _icons[name.trim().toLowerCase()] ?? Icons.luggage_outlined;
}

/// Keys available in the add-item picker (kebab/snake style).
const List<String> kPackingIconChoiceKeys = [
  'luggage',
  'badge',
  'flight',
  'hotel',
  'event',
  'checkroom',
  'medication',
  'hygiene',
  'description',
  'credit_card',
  'smartphone',
  'headphones',
  'umbrella',
  'sunny',
  'restaurant',
  'coffee',
  'charger',
  'camera',
  'child_care',
  'pets',
];

final Map<String, IconData> _icons = {
  'luggage': Icons.luggage_outlined,
  'badge': Icons.badge_outlined,
  'flight': Icons.flight_outlined,
  'hotel': Icons.hotel_outlined,
  'event': Icons.event_outlined,
  'checkroom': Icons.checkroom_outlined,
  'medication': Icons.medication_outlined,
  'hygiene': Icons.cleaning_services_outlined,
  'description': Icons.description_outlined,
  'credit_card': Icons.credit_card_outlined,
  'smartphone': Icons.smartphone_outlined,
  'headphones': Icons.headphones_outlined,
  'umbrella': Icons.umbrella_outlined,
  'sunny': Icons.wb_sunny_outlined,
  'restaurant': Icons.restaurant_outlined,
  'coffee': Icons.coffee_outlined,
  'charger': Icons.electrical_services_outlined,
  'camera': Icons.camera_alt_outlined,
  'child_care': Icons.child_care_outlined,
  'pets': Icons.pets_outlined,
};
