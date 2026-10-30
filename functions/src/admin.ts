import { CallableRequest, HttpsError } from "firebase-functions/v2/https";

export function requireAuth(request: CallableRequest): {
  uid: string;
  email: string;
} {
  if (!request.auth?.uid) {
    throw new HttpsError("unauthenticated", "Sign in required.");
  }
  const email = (request.auth.token.email as string | undefined)?.toLowerCase() ?? "";
  return { uid: request.auth.uid, email };
}

/**
 * Authorizes administrative calls from a Firebase Auth custom claim.
 *
 * Keep the allowlist out of source code: it is personal data and public
 * repository content. Administrators receive the `admin: true` custom claim
 * through `scripts/create_admin_users.js` instead.
 */
export function requireAdmin(request: CallableRequest): {
  uid: string;
  email: string;
} {
  const user = requireAuth(request);
  if (request.auth?.token.admin !== true) {
    throw new HttpsError("permission-denied", "Admin access required.");
  }
  return user;
}
