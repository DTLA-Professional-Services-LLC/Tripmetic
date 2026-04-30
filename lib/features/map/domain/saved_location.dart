import 'package:hive/hive.dart';

/// Hive box name for offline map pins (must match [main] openBox call).
const String kSavedLocationsBoxName = 'saved_locations';

/// Type id for [SavedLocationAdapter] — keep stable after first ship.
const int kSavedLocationTypeId = 50;

/// A user-saved place for offline reference on the map.
class SavedLocation {
  SavedLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;

  /// e.g. Hotel, Food, Landmark
  final String category;
}

class SavedLocationAdapter extends TypeAdapter<SavedLocation> {
  @override
  final int typeId = kSavedLocationTypeId;

  @override
  SavedLocation read(BinaryReader reader) {
    return SavedLocation(
      id: reader.read() as String,
      name: reader.read() as String,
      latitude: reader.read() as double,
      longitude: reader.read() as double,
      category: reader.read() as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedLocation obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.latitude);
    writer.write(obj.longitude);
    writer.write(obj.category);
  }
}
