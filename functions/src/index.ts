import { initializeApp } from "firebase-admin/app";
import { getFirestore, FieldValue } from "firebase-admin/firestore";
import { getMessaging } from "firebase-admin/messaging";
import { setGlobalOptions } from "firebase-functions/v2";
import { onCall, HttpsError } from "firebase-functions/v2/https";
import { defineSecret } from "firebase-functions/params";

import { requireAdmin, requireAuth } from "./admin";
import {
  ALLOWED_BATCH_SIZES,
  generatePromoCode,
  normalizeCode,
} from "./codes";
import {
  grantLifetimeEntitlement,
  revokeLifetimeEntitlement,
  REVENUECAT_ENTITLEMENT_ID,
} from "./revenuecat";
import {
  USERS_COLLECTION,
  assertNotProtectedAdminTarget,
  computeStats,
  deleteUserAccount,
  fetchAllUserRows,
  filterAndSortUsers,
  setUserBanned,
  type SortField,
} from "./usersAdmin";

initializeApp();
setGlobalOptions({ region: "us-central1", maxInstances: 20 });

const revenueCatSecret = defineSecret("REVENUECAT_SECRET_API_KEY");

const CODES_COLLECTION = "appsumo_codes";
const ALL_USERS_TOPIC = "all_users";

type RedeemRequest = {
  appSumoCode?: string;
  code?: string;
};

type GenerateRequest = {
  count?: number;
  campaign?: string;
  entitlement_type?: string;
};

type GrantRequest = {
  uid?: string;
};

type BroadcastRequest = {
  title?: string;
  body?: string;
};

type ListUsersRequest = {
  search?: string;
  limit?: number;
  sortBy?: SortField;
  sortDir?: "asc" | "desc";
  createdFrom?: string;
  createdTo?: string;
  status?: string;
};

type UidRequest = {
  uid?: string;
  reason?: string;
};

// Target email lookup was intentionally removed. Administrative protection is
// based on Firebase Auth custom claims rather than a public email allowlist.
/**
 * Public redeem flow (authenticated).
 * Client creates Firebase Auth user first, then calls this with the promo code.
 * Uses context.auth.uid as the RevenueCat app_user_id.
 */
export const redeemPromoCode = onCall(
  { secrets: [revenueCatSecret], cors: true },
  async (request) => {
    const { uid } = requireAuth(request);
    const data = request.data as RedeemRequest;
    const raw = data.appSumoCode ?? data.code;
    if (!raw || typeof raw !== "string") {
      throw new HttpsError("invalid-argument", "Redeem code is required.");
    }

    const code = normalizeCode(raw);
    if (!code) {
      throw new HttpsError("invalid-argument", "Redeem code is required.");
    }

    const db = getFirestore();
    const codeRef = db.collection(CODES_COLLECTION).doc(code);

    await db.runTransaction(async (tx) => {
      const snap = await tx.get(codeRef);
      if (!snap.exists) {
        throw new HttpsError("not-found", "Invalid redeem code.");
      }
      const status = snap.get("status") as string | undefined;
      const redeemedBy = snap.get("redeemed_by") as string | undefined;
      if (status === "invalidated" || status === "revoked") {
        throw new HttpsError(
          "failed-precondition",
          "This code is no longer valid."
        );
      }
      // Allow retry when a previous RevenueCat grant failed for this same user.
      const canClaim =
        status === "unredeemed" ||
        (status === "error" && redeemedBy === uid) ||
        (status === "pending" && redeemedBy === uid);
      if (!canClaim) {
        throw new HttpsError(
          "failed-precondition",
          "This code has already been redeemed."
        );
      }
      tx.update(codeRef, {
        status: "pending",
        redeemed_by: uid,
        redeemed_at: FieldValue.serverTimestamp(),
        error_message: FieldValue.delete(),
      });
    });

    try {
      await grantLifetimeEntitlement(revenueCatSecret.value(), uid);
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      await codeRef.set(
        {
          status: "error",
          error_message: message,
          redeemed_by: uid,
          redeemed_at: FieldValue.serverTimestamp(),
        },
        { merge: true }
      );
      throw new HttpsError(
        "internal",
        "Could not grant lifetime access. Please contact support."
      );
    }

    await codeRef.set(
      {
        status: "redeemed",
        redeemed_by: uid,
        redeemed_at: FieldValue.serverTimestamp(),
        error_message: FieldValue.delete(),
      },
      { merge: true }
    );

    await db
      .collection(USERS_COLLECTION)
      .doc(uid)
      .set(
        {
          lifetime_access: true,
          entitlement_status: "lifetime",
          entitlement_id: REVENUECAT_ENTITLEMENT_ID,
          promo_code: code,
          updatedAt: FieldValue.serverTimestamp(),
        },
        { merge: true }
      );

    return {
      success: true,
      entitlement: REVENUECAT_ENTITLEMENT_ID,
      code,
    };
  }
);

/** Admin: bulk-generate promo codes and return them for CSV download. */
export const generatePromoCodes = onCall(
  { timeoutSeconds: 300, memory: "512MiB" },
  async (request) => {
    requireAdmin(request);
    const data = request.data as GenerateRequest;
    const count = Number(data.count);
    if (!ALLOWED_BATCH_SIZES.has(count)) {
      throw new HttpsError(
        "invalid-argument",
        "Count must be 500, 1000, or 2000."
      );
    }

    const campaign =
      typeof data.campaign === "string" && data.campaign.trim()
        ? data.campaign.trim()
        : "default";
    const entitlementType =
      typeof data.entitlement_type === "string" && data.entitlement_type.trim()
        ? data.entitlement_type.trim()
        : REVENUECAT_ENTITLEMENT_ID;

    const db = getFirestore();
    const codes: string[] = [];
    const seen = new Set<string>();

    while (codes.length < count) {
      const code = generatePromoCode("TRIPMETIC");
      if (seen.has(code)) continue;
      seen.add(code);
      codes.push(code);
    }

    // Firestore batch limit is 500 writes.
    const BATCH_LIMIT = 500;
    for (let i = 0; i < codes.length; i += BATCH_LIMIT) {
      const batch = db.batch();
      const slice = codes.slice(i, i + BATCH_LIMIT);
      for (const code of slice) {
        const ref = db.collection(CODES_COLLECTION).doc(code);
        batch.set(ref, {
          code,
          status: "unredeemed",
          campaign,
          entitlement_type: entitlementType,
          created_at: FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    }

    return {
      success: true,
      count: codes.length,
      campaign,
      entitlement_type: entitlementType,
      codes,
    };
  }
);

/** Admin: manually grant lifetime entitlement to a Firebase uid. */
export const grantLifetimeAccess = onCall(
  { secrets: [revenueCatSecret] },
  async (request) => {
    requireAdmin(request);
    const data = request.data as GrantRequest;
    const targetUid = typeof data.uid === "string" ? data.uid.trim() : "";
    if (!targetUid) {
      throw new HttpsError("invalid-argument", "uid is required.");
    }

    try {
      await grantLifetimeEntitlement(revenueCatSecret.value(), targetUid);
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      throw new HttpsError("internal", message);
    }

    await getFirestore()
      .collection(USERS_COLLECTION)
      .doc(targetUid)
      .set(
        {
          lifetime_access: true,
          entitlement_status: "lifetime",
          entitlement_id: REVENUECAT_ENTITLEMENT_ID,
          updatedAt: FieldValue.serverTimestamp(),
          granted_by_admin: true,
        },
        { merge: true }
      );

    return { success: true, uid: targetUid };
  }
);

/** Admin: broadcast FCM notification to topic all_users. */
export const broadcastPush = onCall(async (request) => {
  requireAdmin(request);
  const data = request.data as BroadcastRequest;
  const title = typeof data.title === "string" ? data.title.trim() : "";
  const body = typeof data.body === "string" ? data.body.trim() : "";
  if (!title || !body) {
    throw new HttpsError("invalid-argument", "title and body are required.");
  }

  const messageId = await getMessaging().send({
    topic: ALL_USERS_TOPIC,
    notification: { title, body },
    data: {
      type: "broadcast",
      title,
      body,
    },
    apns: {
      headers: {
        "apns-priority": "10",
        "apns-push-type": "alert",
      },
      payload: {
        aps: {
          sound: "default",
          badge: 1,
          "content-available": 1,
        },
      },
    },
    android: {
      priority: "high",
      notification: {
        channelId: "tripmetic_broadcasts",
        sound: "default",
        priority: "high",
        defaultSound: true,
      },
    },
  });

  return { success: true, messageId };
});

/** Admin: list users with sort, date filter, status filter, and aggregate stats. */
export const listUsers = onCall(
  { timeoutSeconds: 120, memory: "512MiB" },
  async (request) => {
    requireAdmin(request);
    const data = request.data as ListUsersRequest;
    const search = typeof data.search === "string" ? data.search : "";
    const limit = Math.min(Math.max(Number(data.limit) || 200, 1), 2000);
    const sortBy = (data.sortBy ?? "createdAt") as SortField;
    const sortDir = data.sortDir === "asc" ? "asc" : "desc";
    const createdFrom =
      typeof data.createdFrom === "string" ? data.createdFrom : null;
    const createdTo = typeof data.createdTo === "string" ? data.createdTo : null;
    const status = typeof data.status === "string" ? data.status : "all";

    const all = await fetchAllUserRows();
    const stats = computeStats(all);
    const filtered = filterAndSortUsers(all, {
      search,
      createdFrom,
      createdTo,
      status,
      sortBy,
      sortDir,
    });
    const rangeStats = computeStats(filtered);

    return {
      users: filtered.slice(0, limit),
      stats,
      rangeStats,
      returned: Math.min(filtered.length, limit),
      matched: filtered.length,
    };
  }
);

/** Admin: revoke promotional lifetime entitlement. */
export const revokeLifetimeAccess = onCall(
  { secrets: [revenueCatSecret] },
  async (request) => {
    const admin = requireAdmin(request);
    const data = request.data as UidRequest;
    const targetUid = typeof data.uid === "string" ? data.uid.trim() : "";
    if (!targetUid) {
      throw new HttpsError("invalid-argument", "uid is required.");
    }

    try {
      await assertNotProtectedAdminTarget(targetUid, admin.uid);
    } catch (err) {
      throw new HttpsError(
        "failed-precondition",
        err instanceof Error ? err.message : String(err)
      );
    }

    try {
      await revokeLifetimeEntitlement(revenueCatSecret.value(), targetUid);
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      throw new HttpsError("internal", message);
    }

    await getFirestore()
      .collection(USERS_COLLECTION)
      .doc(targetUid)
      .set(
        {
          lifetime_access: false,
          entitlement_status: "none",
          granted_by_admin: FieldValue.delete(),
          updatedAt: FieldValue.serverTimestamp(),
        },
        { merge: true }
      );

    return { success: true, uid: targetUid };
  }
);

/** Admin: disable Auth account + mark banned in Firestore. */
export const banUser = onCall(async (request) => {
  const admin = requireAdmin(request);
  const data = request.data as UidRequest;
  const targetUid = typeof data.uid === "string" ? data.uid.trim() : "";
  if (!targetUid) {
    throw new HttpsError("invalid-argument", "uid is required.");
  }
  try {
    await assertNotProtectedAdminTarget(targetUid, admin.uid);
    await setUserBanned(
      targetUid,
      true,
      typeof data.reason === "string" ? data.reason : ""
    );
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    throw new HttpsError("failed-precondition", message);
  }
  return { success: true, uid: targetUid, banned: true };
});

/** Admin: re-enable Auth account. */
export const unbanUser = onCall(async (request) => {
  const admin = requireAdmin(request);
  const data = request.data as UidRequest;
  const targetUid = typeof data.uid === "string" ? data.uid.trim() : "";
  if (!targetUid) {
    throw new HttpsError("invalid-argument", "uid is required.");
  }
  try {
    await assertNotProtectedAdminTarget(targetUid, admin.uid);
    await setUserBanned(targetUid, false);
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    throw new HttpsError("failed-precondition", message);
  }
  return { success: true, uid: targetUid, banned: false };
});

/** Admin: permanently delete Auth user + profile doc. */
export const deleteUser = onCall(async (request) => {
  const admin = requireAdmin(request);
  const data = request.data as UidRequest;
  const targetUid = typeof data.uid === "string" ? data.uid.trim() : "";
  if (!targetUid) {
    throw new HttpsError("invalid-argument", "uid is required.");
  }
  try {
    await assertNotProtectedAdminTarget(targetUid, admin.uid);
    await deleteUserAccount(targetUid);
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    throw new HttpsError("failed-precondition", message);
  }
  return { success: true, uid: targetUid };
});
