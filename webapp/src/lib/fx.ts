import { doc, getDoc } from "firebase/firestore";
import { getFirebaseDb } from "@/lib/firebase";

const FIAT_CACHE_KEY = "tripmetic_fx_fiat_v1";
const CRYPTO_CACHE_KEY = "tripmetic_fx_crypto_v1";
const PAIR_CACHE_KEY = "tripmetic_fx_pair_v1";

/** Same TTL as the mobile app's Hive cache. */
export const RATES_TTL_MS = 12 * 60 * 60 * 1000;

export type RateBook = {
  /** Fiat: units of currency per 1 USD. Crypto: USD price of 1 unit. */
  rates: Record<string, number>;
  updatedAt: string;
  source: "firestore" | "frankfurter" | "cache";
};

export type SavedPair = {
  mode: "fiat" | "crypto";
  from: string;
  to: string;
  amount: string;
  destinations?: string[];
};

function parseUpdatedAt(data: Record<string, unknown>): string {
  const v = data.updatedAt ?? data.updated_at ?? data.asOf ?? data.timestamp ?? data.last_updated;
  if (v && typeof v === "object" && v !== null && "toDate" in v && typeof (v as { toDate: () => Date }).toDate === "function") {
    return (v as { toDate: () => Date }).toDate().toISOString();
  }
  if (typeof v === "string") {
    const parsed = Date.parse(v);
    if (!Number.isNaN(parsed)) return new Date(parsed).toISOString();
  }
  if (typeof v === "number") return new Date(v).toISOString();
  return new Date().toISOString();
}

function extractRatesMap(data: Record<string, unknown>): Record<string, unknown> | null {
  for (const key of ["rates", "exchange_rates", "fx", "exchangeRates", "prices", "data"]) {
    const raw = data[key];
    if (raw && typeof raw === "object" && !Array.isArray(raw)) {
      return raw as Record<string, unknown>;
    }
  }
  return null;
}

function toPositiveNumber(value: unknown): number | null {
  if (typeof value === "number" && Number.isFinite(value) && value > 0) return value;
  if (typeof value === "string") {
    const n = Number(value.trim().replace(/,/g, ""));
    if (Number.isFinite(n) && n > 0) return n;
  }
  if (value && typeof value === "object") {
    const rec = value as Record<string, unknown>;
    for (const key of ["usd", "USD", "price", "value", "rate", "usdPrice"]) {
      if (rec[key] != null) return toPositiveNumber(rec[key]);
    }
  }
  return null;
}

function normalizeRates(raw: Record<string, unknown>): Record<string, number> {
  const rates: Record<string, number> = { USD: 1 };
  for (const [key, value] of Object.entries(raw)) {
    const code = key.toUpperCase();
    if (code === "ILS" || code === "NIS") continue;
    const n = toPositiveNumber(value);
    if (n == null) continue;
    rates[code] = n;
  }
  rates.USD = 1;
  return rates;
}

function readCache(key: string): RateBook | null {
  try {
    const raw = localStorage.getItem(key);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as RateBook;
    if (!parsed?.rates || typeof parsed.rates !== "object") return null;
    return parsed;
  } catch {
    return null;
  }
}

function writeCache(key: string, book: RateBook): void {
  try {
    localStorage.setItem(key, JSON.stringify(book));
  } catch {
    /* private mode / quota */
  }
}

function isFresh(book: RateBook | null): boolean {
  if (!book?.updatedAt) return false;
  const ts = Date.parse(book.updatedAt);
  if (Number.isNaN(ts)) return false;
  return Date.now() - ts < RATES_TTL_MS;
}

async function readFirestoreBook(collection: string): Promise<RateBook | null> {
  const snap = await getDoc(doc(getFirebaseDb(), collection, "latest"));
  if (!snap.exists()) return null;
  const data = snap.data() as Record<string, unknown>;
  const raw = extractRatesMap(data);
  if (!raw) return null;
  const rates = normalizeRates(raw);
  if (Object.keys(rates).length <= 1) return null;
  return {
    rates,
    updatedAt: parseUpdatedAt(data),
    source: "firestore",
  };
}

async function readFrankfurter(): Promise<RateBook | null> {
  const res = await fetch("https://api.frankfurter.app/latest?from=USD");
  if (!res.ok) return null;
  const json = (await res.json()) as { rates?: Record<string, unknown>; date?: string };
  if (!json.rates) return null;
  const rates = normalizeRates(json.rates);
  if (Object.keys(rates).length <= 1) return null;
  const updatedAt = json.date
    ? new Date(`${json.date}T12:00:00.000Z`).toISOString()
    : new Date().toISOString();
  return { rates, updatedAt, source: "frankfurter" };
}

export function cachedFiatRates(): RateBook | null {
  return readCache(FIAT_CACHE_KEY);
}

export function cachedCryptoRates(): RateBook | null {
  return readCache(CRYPTO_CACHE_KEY);
}

/**
 * Same path as the mobile app: Firestore `fiat_rates/latest`, then Frankfurter
 * if Firestore has no usable overlay. Cached locally for offline use.
 */
export async function loadFiatRates(options?: { force?: boolean }): Promise<RateBook> {
  const cached = readCache(FIAT_CACHE_KEY);
  if (!options?.force && cached && isFresh(cached) && navigator.onLine) {
    return cached;
  }

  if (!navigator.onLine) {
    if (cached) return { ...cached, source: "cache" };
    throw new Error("No cached exchange rates yet. Connect once to download rates.");
  }

  try {
    const remote = await readFirestoreBook("fiat_rates");
    if (remote && Object.keys(remote.rates).length > 1) {
      writeCache(FIAT_CACHE_KEY, remote);
      return remote;
    }
  } catch {
    /* fall through to Frankfurter, matching CompositeFiatRatesDataSource */
  }

  try {
    const fallback = await readFrankfurter();
    if (fallback) {
      writeCache(FIAT_CACHE_KEY, fallback);
      return fallback;
    }
  } catch {
    /* use cache */
  }

  if (cached) return { ...cached, source: "cache" };
  throw new Error("Could not refresh exchange rates.");
}

export async function loadCryptoRates(options?: { force?: boolean }): Promise<RateBook> {
  const cached = readCache(CRYPTO_CACHE_KEY);
  if (!options?.force && cached && isFresh(cached) && navigator.onLine) {
    return cached;
  }
  if (!navigator.onLine) {
    if (cached) return { ...cached, source: "cache" };
    throw new Error("No cached crypto rates yet. Connect once to download rates.");
  }
  try {
    const remote = await readFirestoreBook("crypto_rates");
    if (remote && Object.keys(remote.rates).length > 1) {
      writeCache(CRYPTO_CACHE_KEY, remote);
      return remote;
    }
  } catch {
    /* cache */
  }
  if (cached) return { ...cached, source: "cache" };
  throw new Error("Could not refresh crypto rates.");
}

/** Fiat rates are units per 1 USD. */
export function convertFiat(amount: number, from: string, to: string, rates: Record<string, number>): number | null {
  const fromRate = rates[from.toUpperCase()];
  const toRate = rates[to.toUpperCase()];
  if (!fromRate || !toRate) return null;
  return (amount / fromRate) * toRate;
}

/** Crypto rates are USD per 1 unit. Fiat rates are units per 1 USD. */
export function convertCryptoToFiat(
  amount: number,
  crypto: string,
  fiat: string,
  cryptoRates: Record<string, number>,
  fiatRates: Record<string, number>
): number | null {
  const usdPrice = cryptoRates[crypto.toUpperCase()];
  const fiatPerUsd = fiatRates[fiat.toUpperCase()];
  if (!usdPrice || !fiatPerUsd) return null;
  return amount * usdPrice * fiatPerUsd;
}

export function convertFiatToCrypto(
  amount: number,
  fiat: string,
  crypto: string,
  cryptoRates: Record<string, number>,
  fiatRates: Record<string, number>
): number | null {
  const usdPrice = cryptoRates[crypto.toUpperCase()];
  const fiatPerUsd = fiatRates[fiat.toUpperCase()];
  if (!usdPrice || !fiatPerUsd) return null;
  return (amount / fiatPerUsd) / usdPrice;
}

export function readSavedPair(): SavedPair | null {
  try {
    const raw = localStorage.getItem(PAIR_CACHE_KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as SavedPair;
    if (!parsed?.from) return null;
    if (!parsed.to && !parsed.destinations?.length) return null;
    return parsed;
  } catch {
    return null;
  }
}

export function writeSavedPair(pair: SavedPair): void {
  try {
    localStorage.setItem(PAIR_CACHE_KEY, JSON.stringify(pair));
  } catch {
    /* ignore */
  }
}

export function formatUpdatedAt(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return "Unknown";
  return new Intl.DateTimeFormat("en", {
    dateStyle: "medium",
    timeStyle: "short",
  }).format(date);
}
