class DualCityPreset {
  const DualCityPreset({
    required this.label,
    required this.timezoneId,
  });

  final String label;
  final String timezoneId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DualCityPreset &&
          label == other.label &&
          timezoneId == other.timezoneId;

  @override
  int get hashCode => Object.hash(label, timezoneId);
}
