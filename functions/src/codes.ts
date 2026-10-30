import { randomBytes } from "crypto";

const ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

/** Secure random segment of length 4 from a readable alphabet. */
function segment(length = 4): string {
  const bytes = randomBytes(length);
  let out = "";
  for (let i = 0; i < length; i++) {
    out += ALPHABET[bytes[i]! % ALPHABET.length];
  }
  return out;
}

/** e.g. TRIPMETIC-XXXX-XXXX-XXXX */
export function generatePromoCode(prefix = "TRIPMETIC"): string {
  return `${prefix}-${segment()}-${segment()}-${segment()}`;
}

export function normalizeCode(raw: string): string {
  return raw.trim().toUpperCase().replace(/\s+/g, "");
}

export const ALLOWED_BATCH_SIZES = new Set([500, 1000, 2000]);
