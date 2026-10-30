import { getAuth } from "firebase-admin/auth";
import {
  getFirestore,
  FieldValue,
  Timestamp,
  type DocumentData,
  type QueryDocumentSnapshot,
} from "firebase-admin/firestore";

export const USERS_COLLECTION = "users";

export type UserRow = {
  uid: string;
  email: string;
  displayName: string;
  createdAt: string | null;
  lastLoginAt: string | null;
  entitlement_status: string;
  lifetime_access: boolean;
  platform: string;
  platformVersion: string;
  banned: boolean;
  bannedAt: string | null;
  banReason: string;
  isPremium: boolean;
};

export type UserStats = {
  total: number;
  free: number;
  premium: number;
  banned: number;
  byPlatform: Record<string, number>;
};

export type SortField =
  | "uid"
  | "email"
  | "displayName"
  | "createdAt"
  | "lastLoginAt"
  | "entitlement_status"
  | "platform"
  | "banned"
  | "lifetime_access";

function tsToIso(value: unknown): string | null {
  if (!value) return null;
  if (value instanceof Timestamp) {
    return value.toDate().toISOString();
  }
  if (
    typeof value === "object" &&
    value !== null &&
    "toDate" in value &&
    typeof (value as { toDate: () => Date }).toDate === "function"
  ) {
    try {
      return (value as { toDate: () => Date }).toDate().toISOString();
    } catch {
      return null;
    }
  }
  if (typeof value === "string") return value;
  return null;
}

export function isPremiumUser(d: {
  lifetime_access?: unknown;
  entitlement_status?: unknown;
}): boolean {
  if (Boolean(d.lifetime_access)) return true;
  const status = String(d.entitlement_status ?? "none").toLowerCase();
  return ["lifetime", "active", "pro", "premium", "subscribed"].includes(status);
}

export function mapUserDoc(uid: string, d: DocumentData): UserRow {
  const lifetime = Boolean(d.lifetime_access);
  const status = (d.entitlement_status as string) ?? "none";
  const premium = isPremiumUser({ lifetime_access: lifetime, entitlement_status: status });
  return {
    uid,
    email: (d.email as string) ?? "",
    displayName: (d.displayName as string) ?? "",
    createdAt: tsToIso(d.createdAt),
    lastLoginAt: tsToIso(d.lastLoginAt),
    entitlement_status: status,
    lifetime_access: lifetime,
    platform: ((d.platform as string) ?? "unknown").toLowerCase() || "unknown",
    platformVersion: (d.platformVersion as string) ?? "",
    banned: Boolean(d.banned),
    bannedAt: tsToIso(d.bannedAt),
    banReason: (d.banReason as string) ?? "",
    isPremium: premium,
  };
}

export async function fetchAllUserRows(maxDocs = 5000): Promise<UserRow[]> {
  const db = getFirestore();
  const users: UserRow[] = [];
  let last: QueryDocumentSnapshot | undefined;

  while (users.length < maxDocs) {
    let q = db
      .collection(USERS_COLLECTION)
      .orderBy("__name__")
      .limit(Math.min(500, maxDocs - users.length));
    if (last) q = q.startAfter(last);
    const snap = await q.get();
    if (snap.empty) break;
    for (const doc of snap.docs) {
      users.push(mapUserDoc(doc.id, doc.data()));
    }
    last = snap.docs[snap.docs.length - 1];
    if (snap.size < 500) break;
  }

  return users;
}

export function computeStats(users: UserRow[]): UserStats {
  const byPlatform: Record<string, number> = {};
  let free = 0;
  let premium = 0;
  let banned = 0;
  for (const u of users) {
    if (u.banned) banned += 1;
    if (u.isPremium) premium += 1;
    else free += 1;
    const key = u.platform || "unknown";
    byPlatform[key] = (byPlatform[key] ?? 0) + 1;
  }
  return { total: users.length, free, premium, banned, byPlatform };
}

export function filterAndSortUsers(
  users: UserRow[],
  opts: {
    search?: string;
    createdFrom?: string | null;
    createdTo?: string | null;
    status?: string;
    sortBy?: SortField;
    sortDir?: "asc" | "desc";
  }
): UserRow[] {
  let out = [...users];
  const search = (opts.search ?? "").trim().toLowerCase();
  if (search) {
    out = out.filter(
      (u) =>
        u.email.toLowerCase().includes(search) ||
        u.displayName.toLowerCase().includes(search) ||
        u.uid.toLowerCase().includes(search) ||
        u.platform.toLowerCase().includes(search)
    );
  }

  const fromMs = opts.createdFrom ? Date.parse(opts.createdFrom) : NaN;
  const toMs = opts.createdTo ? Date.parse(opts.createdTo) : NaN;
  if (!Number.isNaN(fromMs) || !Number.isNaN(toMs)) {
    out = out.filter((u) => {
      if (!u.createdAt) return false;
      const t = Date.parse(u.createdAt);
      if (Number.isNaN(t)) return false;
      if (!Number.isNaN(fromMs) && t < fromMs) return false;
      if (!Number.isNaN(toMs) && t > toMs) return false;
      return true;
    });
  }

  const status = (opts.status ?? "all").toLowerCase();
  if (status === "free") out = out.filter((u) => !u.isPremium && !u.banned);
  else if (status === "premium") out = out.filter((u) => u.isPremium);
  else if (status === "banned") out = out.filter((u) => u.banned);
  else if (status === "lifetime") out = out.filter((u) => u.lifetime_access);

  const sortBy = opts.sortBy ?? "createdAt";
  const dir = opts.sortDir === "asc" ? 1 : -1;
  out.sort((a, b) => {
    const av = a[sortBy];
    const bv = b[sortBy];
    if (typeof av === "boolean" && typeof bv === "boolean") {
      return (Number(av) - Number(bv)) * dir;
    }
    const as = av == null ? "" : String(av);
    const bs = bv == null ? "" : String(bv);
    return as.localeCompare(bs, undefined, { sensitivity: "base" }) * dir;
  });

  return out;
}

/** Prevents an administrator from changing or deleting another admin account. */
export async function assertNotProtectedAdminTarget(
  uid: string,
  actorUid: string
): Promise<void> {
  if (uid === actorUid) {
    throw new Error("You cannot perform this action on your own account.");
  }

  const target = await getAuth().getUser(uid);
  if (target.customClaims?.admin === true) {
    throw new Error("Cannot modify a protected admin account.");
  }
}

export async function setUserBanned(
  uid: string,
  banned: boolean,
  banReason = ""
): Promise<void> {
  const auth = getAuth();
  await auth.updateUser(uid, { disabled: banned });
  const ref = getFirestore().collection(USERS_COLLECTION).doc(uid);
  if (banned) {
    await ref.set(
      {
        banned: true,
        bannedAt: FieldValue.serverTimestamp(),
        banReason: banReason.trim() || "Banned by admin",
        updatedAt: FieldValue.serverTimestamp(),
      },
      { merge: true }
    );
  } else {
    await ref.set(
      {
        banned: false,
        bannedAt: FieldValue.delete(),
        banReason: FieldValue.delete(),
        updatedAt: FieldValue.serverTimestamp(),
      },
      { merge: true }
    );
  }
}

export async function deleteUserAccount(uid: string): Promise<void> {
  const db = getFirestore();
  await db.collection(USERS_COLLECTION).doc(uid).delete().catch(() => undefined);
  await getAuth().deleteUser(uid);
}
