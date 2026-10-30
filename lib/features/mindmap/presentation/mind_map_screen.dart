import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/navigation/nav_feature_ids.dart';
import '../../../core/subscription/subscription_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/tripmetic_panel_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../../../shared/widgets/pro_glass_overlay.dart';
import '../application/mind_map_providers.dart';
import '../domain/mind_map_layout.dart';
import 'mind_map_png_export.dart';
import 'painters/mind_map_dot_grid_painter.dart';
import 'painters/mind_map_edges_painter.dart';
import 'widgets/mind_map_node_tile.dart';

/// Brainstorming mind map: infinite pan/zoom canvas, Bézier links, Hive persistence.
///
/// [InteractiveViewer] uses `constrained: false` with a fixed [MindMapLayout.canvasSize]
/// [SizedBox] so hit-testing matches the full canvas. Dot grid and edges sit under a single
/// [IgnorePointer]; nodes are painted above and receive all gestures.
class MindMapScreen extends ConsumerStatefulWidget {
  const MindMapScreen({super.key});

  @override
  ConsumerState<MindMapScreen> createState() => _MindMapScreenState();
}

class _MindMapScreenState extends ConsumerState<MindMapScreen> {
  /// Caps rasterized export size (memory + PNG encode time). A bit lower keeps isolate work snappy.
  static const double _maxExportImageExtent = 1536;

  final TransformationController _transform = TransformationController();

  /// Keys the [RepaintBoundary] that wraps the drawable canvas (export target).
  final GlobalKey _mindMapCanvasKey = GlobalKey(debugLabel: 'mind_map_canvas');

  bool _busy = false;

  /// When true, the next valid [LayoutBuilder] pass will align the viewport on the canvas cluster.
  bool _pendingViewportCenter = true;

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  double _inverseCanvasScale() {
    final Matrix4 m = _transform.value;
    final s = m.getMaxScaleOnAxis();
    if (s <= 0.001) return 1;
    return 1.0 / s;
  }

  /// One-time center: align canvas center with viewport center via translation only.
  void _centerViewportTranslateOnce(Size viewport) {
    if (viewport.width <= 0 || viewport.height <= 0) return;
    if (!viewport.width.isFinite || !viewport.height.isFinite) return;
    final cx = MindMapLayout.canvasCenter;
    final cy = MindMapLayout.canvasCenter;
    _transform.value = Matrix4.translationValues(
      viewport.width / 2 - cx,
      viewport.height / 2 - cy,
      0,
    );
  }

  /// Initial open or Reset only — does not run on unrelated rebuilds.
  void _scheduleViewportCenterIfPending(Size viewport) {
    if (!_pendingViewportCenter) return;
    if (viewport.width <= 0 || viewport.height <= 0) return;
    if (!viewport.height.isFinite || !viewport.width.isFinite) return;
    _pendingViewportCenter = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _centerViewportTranslateOnce(viewport);
    });
  }

  /// Returns a pixel ratio so the largest side of the exported bitmap is ≤ [_maxExportImageExtent].
  double _exportPixelRatio(Size logicalSize) {
    final longest = math.max(logicalSize.width, logicalSize.height);
    if (longest <= 0) return 1.0;
    final ratio = _maxExportImageExtent / longest;
    // Match or stay below logical resolution (avoid upscaling); downscale large canvases only.
    return ratio < 1.0 ? ratio : 1.0;
  }

  Future<Uint8List?> _capturePngFromBoundary() async {
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 16));
    final boundary =
        _mindMapCanvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null || !boundary.hasSize) {
      return null;
    }
    final pr = _exportPixelRatio(boundary.size);
    ui.Image? raster;
    try {
      raster = await boundary.toImage(pixelRatio: pr);
      final w = raster.width;
      final h = raster.height;
      final rgba = await mindMapRgbaFromUiImage(raster);
      if (rgba == null) return null;
      // Heavy DEFLATE runs off the UI thread via [compute].
      return mindMapEncodePngAsync(MindMapPngParams(width: w, height: h, rgba: rgba));
    } catch (e, st) {
      assert(() {
        debugPrint('Mind map PNG capture failed: $e\n$st');
        return true;
      }());
      return null;
    } finally {
      raster?.dispose();
    }
  }

  Future<void> _withIdentityTransform(Future<void> Function() action) async {
    final saved = Matrix4.copy(_transform.value);
    _transform.value = Matrix4.identity();
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 64));
    try {
      await action();
    } finally {
      _transform.value = saved;
    }
  }

  Future<void> _saveToGallery(BuildContext context) async {
    if (_busy) return;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      final granted = await Gal.requestAccess(toAlbum: true);
      if (!granted) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapPhotoAccess),
            backgroundColor: Color(0xFF7F1D1D),
          ),
        );
        return;
      }
      Uint8List? bytes;
      await _withIdentityTransform(() async {
        bytes = await _capturePngFromBoundary();
      });
      if (bytes == null || bytes!.isEmpty) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapCaptureFail),
            backgroundColor: Color(0xFF7F1D1D),
          ),
        );
        return;
      }
      if (!context.mounted) return;
      try {
        await Gal.putImageBytes(
          bytes!,
          name: 'tripmetic_mind_${DateTime.now().millisecondsSinceEpoch}',
        );
      } on GalException catch (e) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapCouldNotSaveType('${e.type}')),
            backgroundColor: const Color(0xFF7F1D1D),
          ),
        );
        return;
      }
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.mindMapSavedPhotos),
          backgroundColor: Color(0xFF14532D),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.mindMapCouldNotSave('$e')),
          backgroundColor: const Color(0xFF7F1D1D),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _emailShare(BuildContext context) async {
    if (_busy) return;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      Uint8List? bytes;
      await _withIdentityTransform(() async {
        bytes = await _capturePngFromBoundary();
      });
      if (bytes == null || bytes!.isEmpty) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapShareCaptureFail),
            backgroundColor: Color(0xFF7F1D1D),
          ),
        );
        return;
      }
      if (!context.mounted) return;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/tripmetic_mind_map_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes!, flush: true);
      if (!context.mounted) return;
      final result = await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png', name: 'Tripmetic_mind_map.png')],
          subject: l10n.mindMapShareSubject,
          text: l10n.mindMapShareText,
        ),
      );
      if (!context.mounted) return;
      if (result.status == ShareResultStatus.success) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapShareCompleted),
            backgroundColor: Color(0xFF14532D),
          ),
        );
      } else if (result.status == ShareResultStatus.dismissed) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapShareSheetClosed),
            backgroundColor: AppColors.surfaceContainer,
          ),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.mindMapShareReady),
            backgroundColor: Color(0xFF1E3A5F),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.mindMapShareFailed('$e')),
          backgroundColor: const Color(0xFF7F1D1D),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _confirmReset(BuildContext context) {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.mindMapClearTitle),
        content: Text(l10n.mindMapClearBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.commonCancel)),
          FilledButton(
            onPressed: () {
              ref.read(mindMapProvider.notifier).resetCanvas();
              Navigator.pop(ctx);
              setState(() => _pendingViewportCenter = true);
            },
            child: Text(l10n.mindMapReset),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doc = ref.watch(mindMapProvider);
    final theme = Theme.of(context);
    final panels = tripmeticPanels(context);
    final scaleInv = _inverseCanvasScale();
    final isPro = ref.watch(isTripmeticProProvider);

    return ProGlassOverlay(
      featureId: NavFeatureIds.mindMap,
      isPro: isPro,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final viewport = Size(constraints.maxWidth, constraints.maxHeight);
              _scheduleViewportCenterIfPending(viewport);
              final canvasSize = Size(MindMapLayout.canvasSize, MindMapLayout.canvasSize);
              return ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: InteractiveViewer(
                  transformationController: _transform,
                  constrained: false,
                  minScale: 0.1,
                  maxScale: 3.0,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  clipBehavior: Clip.none,
                  panEnabled: true,
                  scaleEnabled: true,
                  // [RepaintBoundary] wraps the explicit canvas for PNG export; must be inside the viewer.
                  child: RepaintBoundary(
                    key: _mindMapCanvasKey,
                    child: SizedBox(
                      width: MindMapLayout.canvasSize,
                      height: MindMapLayout.canvasSize,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // LAYER 1 — dot grid + Bézier edges: no hit testing (see-through to nodes).
                          IgnorePointer(
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: canvasSize,
                                  painter: MindMapDotGridPainter(
                                    dotColor: panels.canvasDot,
                                  ),
                                ),
                                CustomPaint(
                                  size: canvasSize,
                                  painter: MindMapEdgesPainter(nodes: doc.nodes),
                                ),
                              ],
                            ),
                          ),
                          // LAYER 2 — interactive nodes (after background so they receive all pointers).
                          for (final n in doc.nodes)
                            Positioned(
                              left: n.x,
                              top: n.y,
                              child: MindMapNodeTile(
                                key: ValueKey<String>(n.id),
                                node: n,
                                isActive: doc.activeNodeId == n.id,
                                scaleInverse: scaleInv,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: panels.toolbar,
              border: Border(
                top: BorderSide(color: panels.toolbarBorder),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _busy ? null : () => _saveToGallery(context),
                        icon: _busy
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.onAccent,
                                ),
                              )
                            : const Icon(Icons.image_outlined, size: 22),
                        label: Text(
                          context.l10n.mindMapSavePhoto,
                          style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.onAccent,
                              ) ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onAccent,
                              ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.onAccent,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _busy ? null : () => _emailShare(context),
                        icon: const Icon(Icons.share_outlined, size: 22),
                        label: Text(
                          context.l10n.mindMapEmailShare,
                          style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.onAccent,
                              ) ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onAccent,
                              ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filled(
                      tooltip: context.l10n.mindMapClearTooltip,
                      onPressed: _busy ? null : () => _confirmReset(context),
                      icon: const Icon(Icons.restart_alt_rounded, size: 26),
                      style: IconButton.styleFrom(
                        minimumSize: const Size(52, 52),
                        padding: const EdgeInsets.all(12),
                        backgroundColor: panels.inputFill,
                        foregroundColor: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  context.l10n.mindMapHelpHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                        color: panels.muted,
                        fontSize: 13,
                        height: 1.35,
                      ) ??
                      TextStyle(
                        color: panels.muted,
                        fontSize: 13,
                        height: 1.35,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }
}
