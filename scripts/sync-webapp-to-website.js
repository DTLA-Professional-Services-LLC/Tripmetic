#!/usr/bin/env node
/**
 * Copies the Next.js static export (webapp/out) into website/ so Firebase Hosting
 * serves /redeem and /admin alongside the marketing site.
 */
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const outDir = path.join(root, "webapp", "out");
const websiteDir = path.join(root, "website");

const MARKETING_404 = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex, follow">
  <title>Page not found · Tripmetic</title>
  <link rel="canonical" href="https://tripmetic.app/">
  <style>
    body { margin: 0; min-height: 100vh; display: grid; place-items: center;
      font-family: Georgia, "Times New Roman", serif; background: #0b1f2a; color: #f5f0e8; }
    main { text-align: center; padding: 2rem; }
    a { color: #c9a84c; }
  </style>
</head>
<body>
  <main>
    <h1>Page not found</h1>
    <p><a href="https://tripmetic.app/">Back to Tripmetic</a></p>
  </main>
</body>
</html>
`;

function rmrf(target) {
  if (fs.existsSync(target)) {
    fs.rmSync(target, { recursive: true, force: true });
  }
}

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const from = path.join(src, entry.name);
    const to = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDir(from, to);
    } else {
      fs.copyFileSync(from, to);
    }
  }
}

if (!fs.existsSync(outDir)) {
  console.error("Missing webapp/out. Run: npm --prefix webapp run build");
  process.exit(1);
}

// Remove previous synced Next assets from marketing public dir.
rmrf(path.join(websiteDir, "_next"));
rmrf(path.join(websiteDir, "redeem"));
rmrf(path.join(websiteDir, "admin"));
rmrf(path.join(websiteDir, "404"));
rmrf(path.join(websiteDir, "_not-found"));
for (const name of ["redeem.html", "admin.html", "404.html"]) {
  const p = path.join(websiteDir, name);
  if (fs.existsSync(p)) fs.unlinkSync(p);
}

// Copy everything from export except overwriting the marketing index.
for (const entry of fs.readdirSync(outDir, { withFileTypes: true })) {
  if (entry.name === "index.html" || entry.name === "index.txt") {
    // Keep marketing homepage; Next home is only for local webapp dev.
    continue;
  }
  if (entry.name === "favicon.ico") {
    continue;
  }
  // Never publish Next's crawlable 404 / not-found routes into the marketing site.
  if (entry.name === "404" || entry.name === "_not-found" || entry.name === "404.html") {
    continue;
  }
  const from = path.join(outDir, entry.name);
  const to = path.join(websiteDir, entry.name);
  if (entry.isDirectory()) {
    rmrf(to);
    copyDir(from, to);
  } else {
    fs.copyFileSync(from, to);
  }
}

fs.writeFileSync(path.join(websiteDir, "404.html"), MARKETING_404, "utf8");

console.log("Synced webapp/out → website/ (redeem, admin, currency-calculator, _next; stripped Next 404)");
