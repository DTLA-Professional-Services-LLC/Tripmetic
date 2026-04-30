import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// PNG encoding runs in a worker [Isolate] via [compute] so the UI thread does not freeze
/// during DEFLATE (Flutter's [Image.toByteData] PNG path is synchronous and can block seconds).

@immutable
class MindMapPngParams {
  const MindMapPngParams({
    required this.width,
    required this.height,
    required this.rgba,
  });

  final int width;
  final int height;

  /// Straight RGBA, length == width * height * 4.
  final Uint8List rgba;
}

/// Encodes PNG on a background isolate (except web: runs on current isolate).
Future<Uint8List?> mindMapEncodePngAsync(MindMapPngParams params) async {
  if (kIsWeb) {
    return mindMapPngEncodeSync(params);
  }
  return compute(mindMapPngEncodeSync, params);
}

/// Top-level (required for [compute]).
Uint8List? mindMapPngEncodeSync(MindMapPngParams p) {
  try {
    final im = img.Image.fromBytes(
      width: p.width,
      height: p.height,
      bytes: p.rgba.buffer,
      bytesOffset: p.rgba.offsetInBytes,
      numChannels: 4,
      order: img.ChannelOrder.rgba,
    );
    // level 4 balances size vs CPU; happens off the UI isolate.
    return Uint8List.fromList(img.encodePng(im, level: 4));
  } catch (e, st) {
    assert(() {
      debugPrint('mindMapPngEncodeSync failed: $e\n$st');
      return true;
    }());
    return null;
  }
}

/// Reads RGBA from a rasterized [ui.Image] (call from UI isolate), then callers pass bytes to [mindMapEncodePngAsync].
Future<Uint8List?> mindMapRgbaFromUiImage(ui.Image image) async {
  final bd = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (bd == null) return null;
  final out = Uint8List(bd.lengthInBytes);
  out.setRange(0, out.length, bd.buffer.asUint8List(bd.offsetInBytes, bd.lengthInBytes));
  return out;
}
