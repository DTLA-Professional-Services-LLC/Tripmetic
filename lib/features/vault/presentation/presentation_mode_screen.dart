import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/l10n_helpers.dart';
import '../domain/vault_document.dart';

class PresentationModeScreen extends StatelessWidget {
  const PresentationModeScreen({
    super.key,
    required this.document,
  });

  final VaultDocument document;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // The document viewer
            Positioned.fill(
              child: Hero(
                tag: 'vault_${document.category}',
                child: Material(
                  color: Colors.transparent,
                  child: document.isPdf ? _buildPdfViewer() : _buildImageViewer(),
                ),
              ),
            ),
            
            // Massive Close Button for Immigration Officers
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: Material(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: const CircleBorder(),
                  child: IconButton(
                    iconSize: 48,
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
            
            // Delete Button (bottom left)
            Positioned(
              bottom: 24,
              left: 24,
              child: SafeArea(
                child: Material(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: const CircleBorder(),
                  child: IconButton(
                    iconSize: 28,
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: AppColors.surface,
                          title: Text(l10n.presentationDeleteTitle, style: const TextStyle(color: Colors.white)),
                          content: Text(l10n.presentationDeleteBody, style: const TextStyle(color: AppColors.textSecondary)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(l10n.commonCancel, style: const TextStyle(color: AppColors.textSecondary)),
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text(l10n.commonDelete),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        Navigator.pop(context, 'delete');
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: Image.file(
          File(document.localPath),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                context.l10n.presentationImageLoadFail,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return PDFView(
      filePath: document.localPath,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      fitPolicy: FitPolicy.BOTH,
      onError: (error) {
        debugPrint(error.toString());
      },
      onPageError: (page, error) {
        debugPrint('$page: ${error.toString()}');
      },
    );
  }
}
