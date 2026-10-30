/** ISO 3166-1 alpha-2 for flag emoji. Same conventional map as the mobile app. */
export const CURRENCY_TO_COUNTRY: Record<string, string> = {
  USD: "US",
  EUR: "EU",
  GBP: "GB",
  JPY: "JP",
  CNY: "CN",
  AUD: "AU",
  CAD: "CA",
  CHF: "CH",
  HKD: "HK",
  SGD: "SG",
  KRW: "KR",
  INR: "IN",
  PHP: "PH",
  VND: "VN",
  MXN: "MX",
  BRL: "BR",
  RUB: "RU",
  ZAR: "ZA",
  NZD: "NZ",
  SEK: "SE",
  NOK: "NO",
  DKK: "DK",
  PLN: "PL",
  TRY: "TR",
  THB: "TH",
  IDR: "ID",
  MYR: "MY",
  TWD: "TW",
  AED: "AE",
  SAR: "SA",
  CZK: "CZ",
  HUF: "HU",
  RON: "RO",
  CLP: "CL",
  COP: "CO",
  PEN: "PE",
  ARS: "AR",
  EGP: "EG",
  NGN: "NG",
  PKR: "PK",
  BDT: "BD",
  UAH: "UA",
  KZT: "KZ",
  QAR: "QA",
  KWD: "KW",
  BHD: "BH",
  OMR: "OM",
  JOD: "JO",
  LBP: "LB",
  ISK: "IS",
  BGN: "BG",
  HRK: "HR",
  RSD: "RS",
  BAM: "BA",
  MKD: "MK",
  ALL: "AL",
  MAD: "MA",
  TND: "TN",
  DZD: "DZ",
  XOF: "SN",
  XAF: "CM",
  GHS: "GH",
  KES: "KE",
  UGX: "UG",
  TZS: "TZ",
  ETB: "ET",
  MMK: "MM",
  KHR: "KH",
  LAK: "LA",
  MNT: "MN",
  UZS: "UZ",
  GEL: "GE",
  AMD: "AM",
  AZN: "AZ",
  BYN: "BY",
  MDL: "MD",
  BOB: "BO",
  PYG: "PY",
  UYU: "UY",
  CRC: "CR",
  GTQ: "GT",
  HNL: "HN",
  NIO: "NI",
  PAB: "PA",
  DOP: "DO",
  JMD: "JM",
  TTD: "TT",
  BBD: "BB",
  BSD: "BS",
  BZD: "BZ",
  XCD: "AG",
  FJD: "FJ",
  PGK: "PG",
  SBD: "SB",
  TOP: "TO",
  VUV: "VU",
  WST: "WS",
  XPF: "PF",
  ANG: "CW",
  AWG: "AW",
  SRD: "SR",
  GYD: "GY",
  BMD: "BM",
  KYD: "KY",
  FKP: "FK",
  SHP: "SH",
  GIP: "GI",
  GGP: "GG",
  JEP: "JE",
  IMP: "IM",
  CDF: "CD",
  RWF: "RW",
  BIF: "BI",
  DJF: "DJ",
  ERN: "ER",
  SOS: "SO",
  SSP: "SS",
  SDG: "SD",
  LYD: "LY",
  MRO: "MR",
  MGA: "MG",
  MZN: "MZ",
  MWK: "MW",
  ZMW: "ZM",
  BWP: "BW",
  SZL: "SZ",
  LSL: "LS",
  NAD: "NA",
  AOA: "AO",
  CVE: "CV",
  STN: "ST",
  SCR: "SC",
  MUR: "MU",
  KMF: "KM",
  MVR: "MV",
  BTN: "BT",
  NPR: "NP",
  LKR: "LK",
  AFN: "AF",
  IRR: "IR",
  IQD: "IQ",
  SYP: "SY",
  YER: "YE",
  TMT: "TM",
  TJS: "TJ",
  KGS: "KG",
  MOP: "MO",
  BND: "BN",
  LRD: "LR",
  SLE: "SL",
  GMD: "GM",
  GNF: "GN",
};

const ZERO_DECIMAL = new Set([
  "BIF",
  "CLP",
  "DJF",
  "GNF",
  "ISK",
  "JPY",
  "KMF",
  "KRW",
  "PYG",
  "RWF",
  "UGX",
  "VND",
  "VUV",
  "XAF",
  "XOF",
  "XPF",
]);

const THREE_DECIMAL = new Set(["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"]);

/** Never offer Israeli currency in pickers or defaults. */
const BLOCKED_CURRENCY_CODES = new Set(["ILS", "NIS"]);

export function isExcludedCurrency(code: string, name?: string): boolean {
  const upper = code.trim().toUpperCase();
  if (!upper || BLOCKED_CURRENCY_CODES.has(upper)) return true;
  const label = (name ?? "").toLowerCase();
  return label.includes("israel") || label.includes("shekel");
}

/** App board slot order: first code is the base. Matches kDefaultCurrencySelection. */
export const DEFAULT_FIAT_BOARD = ["USD", "PHP", "VND", "EUR", "JPY", "MXN"] as const;

export const DESTINATION_COUNT = 5;

/** Travel currencies shown first in the picker — same slot order as the app. */
export const FEATURED_FIAT = [
  "USD",
  "EUR",
  "GBP",
  "JPY",
  "PHP",
  "VND",
  "MXN",
  "CAD",
  "AUD",
  "CHF",
  "SGD",
  "THB",
  "KRW",
  "INR",
  "IDR",
  "MYR",
  "CNY",
  "HKD",
  "TWD",
  "AED",
];

export const FEATURED_CRYPTO = [
  "BTC",
  "ETH",
  "USDT",
  "USDC",
  "BNB",
  "SOL",
  "XRP",
  "ADA",
  "DOGE",
  "LTC",
  "AVAX",
  "LINK",
  "DOT",
  "MATIC",
  "BCH",
  "XLM",
];

const CRYPTO_NAMES: Record<string, string> = {
  BTC: "Bitcoin",
  ETH: "Ethereum",
  USDT: "Tether",
  USDC: "USD Coin",
  BNB: "BNB",
  SOL: "Solana",
  XRP: "XRP",
  ADA: "Cardano",
  DOGE: "Dogecoin",
  LTC: "Litecoin",
  AVAX: "Avalanche",
  LINK: "Chainlink",
  DOT: "Polkadot",
  MATIC: "Polygon",
  BCH: "Bitcoin Cash",
  XLM: "Stellar",
};

export function flagEmoji(code: string): string {
  const iso = CURRENCY_TO_COUNTRY[code.toUpperCase()];
  if (!iso || iso.length !== 2) return "💱";
  const a = iso.charCodeAt(0);
  const b = iso.charCodeAt(1);
  return String.fromCodePoint(0x1f1e6 + (a - 65), 0x1f1e6 + (b - 65));
}

export function fiatName(code: string): string {
  const upper = code.toUpperCase();
  try {
    const name = new Intl.DisplayNames(["en"], { type: "currency" }).of(upper);
    if (name && name !== upper) return name;
  } catch {
    /* ignore */
  }
  return upper;
}

export function cryptoName(code: string): string {
  return CRYPTO_NAMES[code.toUpperCase()] ?? code.toUpperCase();
}

export function fiatDecimals(code: string): number {
  const upper = code.toUpperCase();
  if (ZERO_DECIMAL.has(upper)) return 0;
  if (THREE_DECIMAL.has(upper)) return 3;
  return 2;
}

export function formatFiat(value: number, code: string): string {
  if (!Number.isFinite(value)) return "—";
  const digits = fiatDecimals(code);
  return new Intl.NumberFormat("en-US", {
    minimumFractionDigits: digits,
    maximumFractionDigits: digits,
  }).format(value);
}

export function formatCrypto(value: number): string {
  if (!Number.isFinite(value)) return "—";
  if (value === 0) return "0";
  const abs = Math.abs(value);
  const digits = abs >= 1000 ? 2 : abs >= 1 ? 4 : 8;
  const formatted = new Intl.NumberFormat("en-US", {
    minimumFractionDigits: 0,
    maximumFractionDigits: digits,
  }).format(value);
  return formatted;
}

const REGION_CURRENCY: Record<string, string> = {
  US: "USD",
  GB: "GBP",
  JP: "JPY",
  PH: "PHP",
  VN: "VND",
  MX: "MXN",
  CA: "CAD",
  AU: "AUD",
  CH: "CHF",
  SG: "SGD",
  KR: "KRW",
  IN: "INR",
  ID: "IDR",
  MY: "MYR",
  CN: "CNY",
  HK: "HKD",
  TW: "TWD",
  TH: "THB",
  AE: "AED",
  SA: "SAR",
  NZ: "NZD",
  BR: "BRL",
  ZA: "ZAR",
  TR: "TRY",
  PL: "PLN",
  SE: "SEK",
  NO: "NOK",
  DK: "DKK",
  DE: "EUR",
  FR: "EUR",
  ES: "EUR",
  IT: "EUR",
  NL: "EUR",
  IE: "EUR",
  PT: "EUR",
  AT: "EUR",
  BE: "EUR",
  FI: "EUR",
  GR: "EUR",
};

export function guessHomeCurrency(): string {
  try {
    const locale = navigator.language || "en-US";
    const region = new Intl.Locale(locale).region;
    if (region && REGION_CURRENCY[region]) return REGION_CURRENCY[region];
  } catch {
    /* ignore */
  }
  return "USD";
}
