// Generates Tripmetic launcher icons and splash assets (compass ring + chart + chain).
// Run from project root: dart run tool/generate_brand_assets.dart

import 'dart:io';

import 'package:image/image.dart' as img;

const _navyR = 11;
const _navyG = 19;
const _navyB = 43;
const _goldR = 212;
const _goldG = 175;
const _goldB = 55;

img.Color _gold() => img.ColorRgba8(_goldR, _goldG, _goldB, 255);

img.Color _navy() => img.ColorRgba8(_navyR, _navyG, _navyB, 255);

img.Color _clear() => img.ColorRgba8(0, 0, 0, 0);

void _drawAnnulus(
  img.Image im,
  int cx,
  int cy,
  int rOuter,
  int stroke,
  img.Color color,
) {
  final rIn = rOuter - stroke;
  final rIn2 = rIn * rIn;
  final rOut2 = rOuter * rOuter;
  final x0 = (cx - rOuter).clamp(0, im.width - 1);
  final x1 = (cx + rOuter).clamp(0, im.width - 1);
  final y0 = (cy - rOuter).clamp(0, im.height - 1);
  final y1 = (cy + rOuter).clamp(0, im.height - 1);
  for (var y = y0; y <= y1; y++) {
    for (var x = x0; x <= x1; x++) {
      final dx = x - cx;
      final dy = y - cy;
      final d2 = dx * dx + dy * dy;
      if (d2 <= rOut2 && d2 >= rIn2) {
        im.setPixel(x, y, color);
      }
    }
  }
}

/// Paints the brand mark. [fillBackground] true = full app icon on navy; false = transparent
/// background for adaptive foreground / splash overlay.
void paintTripmeticMark(img.Image im, {required bool fillBackground}) {
  final w = im.width;
  final h = im.height;
  final cx = w ~/ 2;
  final cy = h ~/ 2 - (h * 0.018).round();

  final gold = _gold();

  if (fillBackground) {
    img.fill(im, color: _navy());
  } else {
    img.fill(im, color: _clear());
  }

  final scale = w / 1024.0;
  final rOuter = (205 * scale).round();
  final stroke = (18 * scale).round().clamp(2, 48);

  _drawAnnulus(im, cx, cy, rOuter, stroke, gold);

  // Compass needle (north)
  final tipY = cy - rOuter + stroke + (22 * scale).round();
  final baseY = cy - (28 * scale).round();
  final halfW = (36 * scale).round().clamp(6, 56);
  img.fillPolygon(
    im,
    vertices: [
      img.Point(cx, tipY),
      img.Point(cx - halfW, baseY),
      img.Point(cx + halfW, baseY),
    ],
    color: gold,
  );

  // Budget-style bar chart
  final barW = (26 * scale).round().clamp(4, 36);
  final gap = (11 * scale).round().clamp(2, 18);
  final barBaseY = cy + (32 * scale).round();
  final maxH = (88 * scale).round();
  const heights = <double>[0.56, 0.88, 0.68];
  final totalW = barW * 3 + gap * 2;
  var bx = cx - totalW ~/ 2;
  for (var i = 0; i < 3; i++) {
    final bh = (maxH * heights[i]).round();
    img.fillRect(
      im,
      x1: bx,
      y1: barBaseY - bh,
      x2: bx + barW,
      y2: barBaseY,
      color: gold,
    );
    bx += barW + gap;
  }

  // Chain links (interlocking circles)
  final linkR = (33 * scale).round().clamp(4, 50);
  final linkY = cy + (188 * scale).round();
  final offsetX = (40 * scale).round();
  img.fillCircle(
    im,
    x: cx - offsetX,
    y: linkY,
    radius: linkR,
    color: gold,
    antialias: true,
  );
  img.fillCircle(
    im,
    x: cx + offsetX,
    y: linkY,
    radius: linkR,
    color: gold,
    antialias: true,
  );
}

img.Image _makeIcon({required int size, required bool fillBackground}) {
  final im = img.Image(width: size, height: size, numChannels: 4);
  paintTripmeticMark(im, fillBackground: fillBackground);
  return im;
}

Future<void> main() async {
  final root = Directory.current;
  final assetsBrand = Directory.fromUri(root.uri.resolve('assets/brand/'));
  final androidDrawable = Directory.fromUri(
    root.uri.resolve('android/app/src/main/res/drawable/'),
  );
  final iosLaunch = Directory.fromUri(
    root.uri.resolve('ios/Runner/Assets.xcassets/LaunchImage.imageset/'),
  );

  await assetsBrand.create(recursive: true);
  await androidDrawable.create(recursive: true);
  await iosLaunch.create(recursive: true);

  final icon = _makeIcon(size: 1024, fillBackground: true);
  final foreground = _makeIcon(size: 1024, fillBackground: false);

  File.fromUri(assetsBrand.uri.resolve('app_icon.png'))
      .writeAsBytesSync(img.encodePng(icon));
  File.fromUri(assetsBrand.uri.resolve('app_icon_foreground.png'))
      .writeAsBytesSync(img.encodePng(foreground));

  // Android splash: centered gold mark on transparent (navy from layer-list).
  final splash = _makeIcon(size: 512, fillBackground: false);
  File.fromUri(androidDrawable.uri.resolve('brand_splash_logo.png'))
      .writeAsBytesSync(img.encodePng(splash));

  // iOS LaunchImage (@1x / @2x / @3x).
  File.fromUri(iosLaunch.uri.resolve('LaunchImage.png'))
      .writeAsBytesSync(img.encodePng(_makeIcon(size: 256, fillBackground: false)));
  File.fromUri(iosLaunch.uri.resolve('LaunchImage@2x.png'))
      .writeAsBytesSync(img.encodePng(_makeIcon(size: 512, fillBackground: false)));
  File.fromUri(iosLaunch.uri.resolve('LaunchImage@3x.png'))
      .writeAsBytesSync(img.encodePng(_makeIcon(size: 768, fillBackground: false)));

  // ignore: avoid_print
  print('Wrote brand assets under assets/brand/, Android drawable, iOS LaunchImage.');
}
