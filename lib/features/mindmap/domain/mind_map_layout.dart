/// Shared canvas geometry for mind map nodes, painting, and drag math.
abstract final class MindMapLayout {
  static const double canvasSize = 4000;

  static double get canvasCenter => canvasSize / 2;

  /// Full node card size (drag handle + text + actions). Used by edge painting.
  static const double dragHandleWidth = 32;
  static const double actionColumnWidth = 36;
  static const double nodeWidth = 268;

  /// Tall enough for drag handle + text + two stacked action icons without overflow.
  static const double nodeHeight = 100;

  static double get rootTopLeftX => canvasCenter - nodeWidth / 2;
  static double get rootTopLeftY => canvasCenter - nodeHeight / 2;

  /// Default offset for a child created via the [+] control (relative to parent's top-left).
  static const double newChildOffsetX = 150;
  static const double newChildOffsetY = 100;
}
