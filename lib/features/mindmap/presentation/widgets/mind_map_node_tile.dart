import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/l10n_helpers.dart';
import '../../application/mind_map_providers.dart';
import '../../domain/mind_map_layout.dart';
import '../../domain/mind_map_node.dart';

/// Mind map node using a **drag handle** so pan and tap never share one [GestureDetector].
///
/// [Row]: drag handle (pan) | text ([onTap] edit) | action [Column] ([IconButton]s).
class MindMapNodeTile extends ConsumerStatefulWidget {
  const MindMapNodeTile({
    super.key,
    required this.node,
    required this.isActive,
    required this.scaleInverse,
  });

  final MindMapNode node;
  final bool isActive;
  final double scaleInverse;

  @override
  ConsumerState<MindMapNodeTile> createState() => _MindMapNodeTileState();
}

class _MindMapNodeTileState extends ConsumerState<MindMapNodeTile> {
  Future<void> _showEditDialog() async {
    final notifier = ref.read(mindMapProvider.notifier);
    notifier.selectNode(widget.node.id);

    final controller = TextEditingController(text: widget.node.text);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          context.l10n.mindMapNodeEditTitle,
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          maxLength: 120,
          style: const TextStyle(
            color: Color(0xFFF1F5F9),
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: context.l10n.mindMapNodeHint,
            hintStyle: TextStyle(color: Color(0xFF64748B)),
            filled: true,
            fillColor: Color(0xFF243556),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: Text(context.l10n.commonSave),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (result == null) return;

    final trimmed = result.trim();
    final previous = widget.node.text.trim();
    final nextText = trimmed.isEmpty ? (previous.isEmpty ? context.l10n.mindMapEmptyNode : previous) : trimmed;
    notifier.setNodeText(widget.node.id, nextText);
  }

  void _onDragPanStart(DragStartDetails _) {
    final notifier = ref.read(mindMapProvider.notifier);
    notifier.bringToFront(widget.node.id);
    notifier.selectNode(widget.node.id);
  }

  void _onDragPanUpdate(DragUpdateDetails details) {
    ref.read(mindMapProvider.notifier).moveNode(
          widget.node.id,
          details.delta.dx * widget.scaleInverse,
          details.delta.dy * widget.scaleInverse,
        );
  }

  void _onAddChild({required bool isLeft}) {
    ref.read(mindMapProvider.notifier).addChildTo(widget.node.id, isLeft: isLeft);
  }

  void _onDelete() {
    ref.read(mindMapProvider.notifier).deleteNode(widget.node.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = widget.isActive
        ? AppColors.accent.withValues(alpha: 0.92)
        : const Color(0xFF475569).withValues(alpha: 0.85);
    final isRoot = widget.node.parentId == null;

    return Material(
      color: const Color(0xFF1E293B),
      elevation: widget.isActive ? 6 : 2,
      shadowColor: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MindMapLayout.nodeWidth,
        height: MindMapLayout.nodeHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: widget.isActive ? 1.8 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hit zone 1: drag handle and left add button.
            SizedBox(
              width: MindMapLayout.dragHandleWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                    iconSize: 20,
                    tooltip: context.l10n.mindMapNodeAddLeftTooltip,
                    onPressed: () => _onAddChild(isLeft: true),
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.accent,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: _onDragPanStart,
                    onPanUpdate: _onDragPanUpdate,
                    child: SizedBox(
                      width: MindMapLayout.dragHandleWidth,
                      height: 32,
                      child: Center(
                        child: Icon(
                          Icons.drag_indicator,
                          size: 22,
                          color: AppColors.textSecondary.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Hit zone 2: text — tap / edit only (no pan).
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _showEditDialog,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.node.text.isEmpty ? context.l10n.mindMapTapToEdit : widget.node.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                            color: widget.node.text.isEmpty
                                ? const Color(0xFF64748B)
                                : const Color(0xFFF1F5F9),
                            fontWeight: FontWeight.w600,
                            height: 1.12,
                          ) ??
                          TextStyle(
                            color: widget.node.text.isEmpty
                                ? const Color(0xFF64748B)
                                : const Color(0xFFF1F5F9),
                            fontWeight: FontWeight.w600,
                            height: 1.12,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            // Hit zone 3: actions — [IconButton] uses separate recognizers (no pan on card).
            SizedBox(
              width: MindMapLayout.actionColumnWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                    iconSize: 20,
                    tooltip: context.l10n.mindMapNodeAddRightTooltip,
                    onPressed: () => _onAddChild(isLeft: false),
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.accent,
                    ),
                  ),
                  if (!isRoot)
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                      iconSize: 20,
                      tooltip: context.l10n.mindMapNodeDeleteTooltip,
                      onPressed: _onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
