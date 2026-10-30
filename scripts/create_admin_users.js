#!/usr/bin/env node
/**
 * Create Super Admin Firebase Auth users and set custom claim { admin: true }.
 *
 * Required environment variables:
 *   FIREBASE_PROJECT_ID      Firebase project to administer
 *   ADMIN_EMAILS             Comma-separated admin email addresses
 *
 * Authentication uses Google Application Default Credentials. For a service
 * account, set:
 *   GOOGLE_APPLICATION_CREDENTIALS=/path/to/adminsdk.json
 *
 * Optional:
 *   ADMIN_TEMP_PASSWORD      Shared temporary password (otherwise generated)
 *
 * Usage (from repo root):
 *   FIREBASE_PROJECT_ID=your-project \
 *   ADMIN_EMAILS='admin@example.com,other-admin@example.com' \
 *   node scripts/create_admin_users.js
 */
const crypto = require("crypto");
const admin = require("firebase-admin");

function requiredEnvironment(name) {
  const value = (process.env[name] || "").trim();
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  return value;
}

function parseAdminEmails(value) {
  return [...new Set(
    value
      .split(",")
      .map((email) => email.trim().toLowerCase())
      .filter(Boolean),
  )];
}

function resolveTempPassword() {
  const configured = (process.env.ADMIN_TEMP_PASSWORD || "").trim();
  if (configured) return configured;
  return `TmAdmin-${crypto.randomBytes(6).toString("base64url")}!`;
}

async function main() {
  const projectId = requiredEnvironment("FIREBASE_PROJECT_ID");
  const admins = parseAdminEmails(requiredEnvironment("ADMIN_EMAILS"));
  if (!admins.length) {
    throw new Error("ADMIN_EMAILS did not contain a valid email address.");
  }

  if (!admin.apps.length) {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      projectId,
    });
  }

  const argv = process.argv.slice(2);
  const resetExisting = argv.includes("--reset-password");
  const tempPassword = resolveTempPassword();
  const auth = admin.auth();
  const created = [];
  const passwordPrintedFor = [];

  for (const email of admins) {
    let user;
    try {
      user = await auth.getUserByEmail(email);
      console.log(`exists: ${email} (${user.uid})`);
      if (resetExisting) {
        await auth.updateUser(user.uid, {
          password: tempPassword,
          emailVerified: true,
        });
        console.log("  password reset");
        passwordPrintedFor.push(email);
      }
    } catch (err) {
      if (err.code !== "auth/user-not-found") throw err;
      user = await auth.createUser({
        email,
        password: tempPassword,
        emailVerified: true,
        displayName: "Tripmetic Admin",
      });
      console.log(`created: ${email} (${user.uid})`);
      created.push(email);
      passwordPrintedFor.push(email);
    }
    await auth.setCustomUserClaims(user.uid, {
      ...(user.customClaims || {}),
      admin: true,
    });
    console.log("  claim admin: true");
  }

  console.log("\n---");
  if (passwordPrintedFor.length) {
    console.log("Temporary password (for newly created / --reset-password accounts):");
    console.log(tempPassword);
    console.log("Accounts:", passwordPrintedFor.join(", "));
    console.log("Sign in at https://tripmetic.app/admin/login then change the password.");
  } else {
    console.log("No passwords changed. Existing accounts keep their current password.");
  }
  if (created.length) {
    console.log("Newly created:", created.join(", "));
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
