import { doc, getDoc, serverTimestamp, setDoc } from "firebase/firestore";
import type { User } from "firebase/auth";
import { getFirebaseDb } from "./firebase";

/** Create or refresh users/{uid} so the admin directory stays populated. */
export async function ensureUserProfileDoc(user: User, displayName?: string) {
  const db = getFirebaseDb();
  const ref = doc(db, "users", user.uid);
  const existing = await getDoc(ref);
  const name =
    displayName?.trim() ||
    user.displayName?.trim() ||
    (existing.exists() ? (existing.data().displayName as string) : "") ||
    "";

  if (!existing.exists()) {
    await setDoc(ref, {
      email: user.email ?? "",
      displayName: name,
      createdAt: serverTimestamp(),
      updatedAt: serverTimestamp(),
      lastLoginAt: serverTimestamp(),
      entitlement_status: "none",
      lifetime_access: false,
      platform: "web",
      platformVersion: typeof navigator !== "undefined" ? navigator.userAgent : "web",
    });
    return;
  }

  await setDoc(
    ref,
    {
      email: user.email ?? existing.data().email ?? "",
      displayName: name || existing.data().displayName || "",
      updatedAt: serverTimestamp(),
      lastLoginAt: serverTimestamp(),
      platform: "web",
      platformVersion: typeof navigator !== "undefined" ? navigator.userAgent : "web",
    },
    { merge: true }
  );
}
