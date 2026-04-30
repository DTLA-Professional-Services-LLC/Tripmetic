import 'package:flutter/material.dart';

/// Material icons for each budget line item.
IconData tripBudgetCategoryIcon(String category) {
  return switch (category) {
    'Flights' => Icons.flight_takeoff_rounded,
    'Hotels' => Icons.hotel_rounded,
    'Transportation' => Icons.directions_transit_rounded,
    'Daily Food' => Icons.restaurant_menu_rounded,
    'Shopping' => Icons.shopping_bag_rounded,
    'Eating Out' => Icons.restaurant_rounded,
    'Grocery' => Icons.shopping_cart_rounded,
    'Entertainment' => Icons.movie_rounded,
    'Tourism' => Icons.photo_camera_rounded,
    'Phone Service' => Icons.smartphone_rounded,
    'Travel Insurance' => Icons.shield_rounded,
    'Misc' => Icons.more_horiz_rounded,
    _ => Icons.payments_rounded,
  };
}
