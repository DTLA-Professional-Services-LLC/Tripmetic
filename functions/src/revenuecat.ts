/**
 * RevenueCat REST API v1 helpers.
 *
 * Set the secret via:
 *   firebase functions:secrets:set REVENUECAT_SECRET_API_KEY
 *
 * Entitlement identifier must match RevenueCat dashboard exactly
 * (lookup key: "Tripmetic Pro", not the entl… id).
 */
export const REVENUECAT_ENTITLEMENT_ID = "Tripmetic Pro";

async function ensureSubscriber(
  secretApiKey: string,
  appUserId: string
): Promise<void> {
  // GET /subscribers/{id} creates the customer if missing.
  const encodedUser = encodeURIComponent(appUserId);
  const url = `https://api.revenuecat.com/v1/subscribers/${encodedUser}`;
  const res = await fetch(url, {
    method: "GET",
    headers: {
      Authorization: `Bearer ${secretApiKey}`,
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`RevenueCat ensure subscriber failed (${res.status}): ${body}`);
  }
}

export async function grantLifetimeEntitlement(
  secretApiKey: string,
  appUserId: string,
  entitlementId: string = REVENUECAT_ENTITLEMENT_ID
): Promise<void> {
  await ensureSubscriber(secretApiKey, appUserId);

  const encodedUser = encodeURIComponent(appUserId);
  const encodedEntitlement = encodeURIComponent(entitlementId);
  const url =
    `https://api.revenuecat.com/v1/subscribers/${encodedUser}` +
    `/entitlements/${encodedEntitlement}/promotional`;

  const res = await fetch(url, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${secretApiKey}`,
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({ duration: "lifetime" }),
  });

  if (!res.ok) {
    const body = await res.text();
    throw new Error(`RevenueCat grant failed (${res.status}): ${body}`);
  }
}

/** Revoke all promotional grants for an entitlement (e.g. admin-granted lifetime). */
export async function revokeLifetimeEntitlement(
  secretApiKey: string,
  appUserId: string,
  entitlementId: string = REVENUECAT_ENTITLEMENT_ID
): Promise<void> {
  const encodedUser = encodeURIComponent(appUserId);
  const encodedEntitlement = encodeURIComponent(entitlementId);
  const url =
    `https://api.revenuecat.com/v1/subscribers/${encodedUser}` +
    `/entitlements/${encodedEntitlement}/revoke_promotionals`;

  const res = await fetch(url, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${secretApiKey}`,
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });

  // 7242 = nothing to revoke — treat as success for idempotent admin UX.
  if (!res.ok) {
    const body = await res.text();
    if (res.status === 404 || body.includes("7242") || body.includes("No promotional")) {
      return;
    }
    throw new Error(`RevenueCat revoke failed (${res.status}): ${body}`);
  }
}
