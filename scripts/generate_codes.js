#!/usr/bin/env node
/**
 * generate_codes.js
 *
 * Generate unique Tripmetic lifetime promo codes, write them to Firestore
 * `appsumo_codes`, and export appsumo_codes.csv for AppSumo / PitchGround / Dealify.
 *
 * Setup:
 * 1. Firebase Console → Project settings → Service accounts → Generate new private key
 * 2. Save the JSON outside git (or locally) and point GOOGLE_APPLICATION_CREDENTIALS at it:
 *
 *    export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/your-firebase-adminsdk.json"
 *
 * 3. Set the target project and run from repo root:
 *
 *    export FIREBASE_PROJECT_ID="your-firebase-project-id"
 *    cd scripts
 *    npm install
 *    node generate_codes.js 500
 *    node generate_codes.js 1000 --campaign=AppSumo_Tier1
 *    node generate_codes.js 2000 --campaign=PitchGround
 *
 * Allowed counts: 500, 1000, 2000
 */

const fs = require("fs");
const path = require("path");
const { randomBytes } = require("crypto");
const admin = require("firebase-admin");

const ALLOWED = new Set([500, 1000, 2000]);
const ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
const ENTITLEMENT = "Tripmetic Pro";

function segment(length = 4) {
  const bytes = randomBytes(length);
  let out = "";
  for (let i = 0; i < length; i++) {
    out += ALPHABET[bytes[i] % ALPHABET.length];
  }
  return out;
}

function generateCode() {
  return `TRIPMETIC-${segment()}-${segment()}-${segment()}`;
}

function parseArgs(argv) {
  const countArg = argv.find((a) => /^\d+$/.test(a));
  const campaignArg = argv.find((a) => a.startsWith("--campaign="));
  const count = countArg ? Number(countArg) : 500;
  const campaign = campaignArg
    ? campaignArg.slice("--campaign=".length)
    : "AppSumo_Tier1";
  return { count, campaign };
}

async function main() {
  const { count, campaign } = parseArgs(process.argv.slice(2));
  if (!ALLOWED.has(count)) {
    console.error("Count must be 500, 1000, or 2000.");
    process.exit(1);
  }

  if (!process.env.GOOGLE_APPLICATION_CREDENTIALS) {
    console.error(
      "Set GOOGLE_APPLICATION_CREDENTIALS to your Firebase Admin SDK JSON path."
    );
    process.exit(1);
  }

  const projectId = (process.env.FIREBASE_PROJECT_ID || "").trim();
  if (!projectId) {
    console.error("Set FIREBASE_PROJECT_ID to the target Firebase project id.");
    process.exit(1);
  }

  if (!admin.apps.length) {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      projectId,
    });
  }

  const db = admin.firestore();
  const codes = [];
  const seen = new Set();
  while (codes.length < count) {
    const code = generateCode();
    if (seen.has(code)) continue;
    seen.add(code);
    codes.push(code);
  }

  const BATCH_LIMIT = 500;
  for (let i = 0; i < codes.length; i += BATCH_LIMIT) {
    const batch = db.batch();
    const slice = codes.slice(i, i + BATCH_LIMIT);
    for (const code of slice) {
      const ref = db.collection("appsumo_codes").doc(code);
      batch.set(ref, {
        code,
        status: "unredeemed",
        campaign,
        entitlement_type: ENTITLEMENT,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
    console.log(`Wrote ${Math.min(i + BATCH_LIMIT, codes.length)} / ${count}`);
  }

  const csvPath = path.join(process.cwd(), "appsumo_codes.csv");
  fs.writeFileSync(csvPath, codes.join("\n") + "\n", "utf8");
  console.log(`Done. Firestore updated. CSV: ${csvPath}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
