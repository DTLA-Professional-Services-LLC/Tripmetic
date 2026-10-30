"use client";

import { useEffect, useId, useMemo, useRef, useState } from "react";
import {
  DEFAULT_FIAT_BOARD,
  DESTINATION_COUNT,
  FEATURED_CRYPTO,
  FEATURED_FIAT,
  cryptoName,
  fiatName,
  flagEmoji,
  formatFiat,
  guessHomeCurrency,
  isExcludedCurrency,
} from "@/lib/currencyMeta";
import {
  cachedCryptoRates,
  cachedFiatRates,
  convertCryptoToFiat,
  convertFiat,
  formatUpdatedAt,
  loadCryptoRates,
  loadFiatRates,
  readSavedPair,
  writeSavedPair,
  type RateBook,
} from "@/lib/fx";
import "./CurrencyCalculator.css";

type Mode = "fiat" | "crypto";
type PickerTarget = { kind: "base" } | { kind: "row"; index: number };

const KEYS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "⌫"] as const;
const FALLBACK_DESTINATIONS = ["PHP", "VND", "EUR", "JPY", "MXN", "GBP", "CAD", "AUD", "CHF", "SGD"];

function sortCodes(codes: string[], featured: string[]): string[] {
  const unique = Array.from(
    new Set(codes.map((code) => code.toUpperCase()).filter((code) => !isExcludedCurrency(code)))
  );
  const featuredSet = new Set(featured);
  const head = featured.filter((code) => unique.includes(code) && !isExcludedCurrency(code));
  const tail = unique
    .filter((code) => !featuredSet.has(code) && code !== "USD")
    .sort((a, b) => a.localeCompare(b));
  return [...head, ...tail];
}

function parseAmount(raw: string): number | null {
  const trimmed = raw.trim().replace(/,/g, "");
  if (!trimmed || trimmed === ".") return null;
  const n = Number(trimmed);
  return Number.isFinite(n) ? n : null;
}

function allowedFiat(code: string, pool: string[]): boolean {
  const upper = code.toUpperCase();
  return pool.includes(upper) && !isExcludedCurrency(upper, fiatName(upper));
}

function fillDestinations(base: string, preferred: string[], pool: string[]): string[] {
  const used = new Set([base.toUpperCase()]);
  const next: string[] = [];
  for (const code of [...preferred, ...DEFAULT_FIAT_BOARD, ...FALLBACK_DESTINATIONS, ...pool]) {
    const upper = code.toUpperCase();
    if (used.has(upper) || !allowedFiat(upper, pool)) continue;
    used.add(upper);
    next.push(upper);
    if (next.length === DESTINATION_COUNT) break;
  }
  return next;
}

export function CurrencyCalculator() {
  const formId = useId();
  const searchId = useId();
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<Mode>("fiat");
  const [from, setFrom] = useState("USD");
  const [destinations, setDestinations] = useState<string[]>(() =>
    DEFAULT_FIAT_BOARD.slice(1, 1 + DESTINATION_COUNT)
  );
  const [amount, setAmount] = useState("100");
  const [fiat, setFiat] = useState<RateBook | null>(null);
  const [crypto, setCrypto] = useState<RateBook | null>(null);
  const [status, setStatus] = useState("Loading exchange rates…");
  const [offline, setOffline] = useState(false);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [picker, setPicker] = useState<PickerTarget | null>(null);
  const [query, setQuery] = useState("");

  useEffect(() => {
    const saved = readSavedPair();
    const home = guessHomeCurrency();
    const savedFrom = saved?.from?.toUpperCase() ?? home;
    const savedMode = saved?.mode === "crypto" ? "crypto" : "fiat";
    const seed = DEFAULT_FIAT_BOARD.slice(1);
    const preferred = (saved?.destinations?.length ? saved.destinations : saved?.to ? [saved.to, ...seed] : seed).map(
      (code) => code.toUpperCase()
    );
    if (savedMode === "crypto" && savedFrom !== "ILS" && savedFrom !== "NIS") {
      setMode("crypto");
      setFrom(savedFrom);
      setDestinations(fillDestinations(home === "USD" ? "EUR" : "USD", preferred, [...DEFAULT_FIAT_BOARD, ...FALLBACK_DESTINATIONS, "USD", "EUR"]));
    } else {
      const base = isExcludedCurrency(savedFrom, fiatName(savedFrom)) ? (home === "ILS" ? "USD" : home) : savedFrom;
      setMode("fiat");
      setFrom(base);
      setDestinations(
        fillDestinations(base, preferred, [...DEFAULT_FIAT_BOARD, ...FALLBACK_DESTINATIONS, "USD", "EUR", "GBP", "CAD", "AUD"])
      );
    }
    if (saved?.amount) setAmount(saved.amount);
    setFiat(cachedFiatRates());
    setCrypto(cachedCryptoRates());
    setOffline(!navigator.onLine);
  }, []);

  useEffect(() => {
    if ("serviceWorker" in navigator) {
      navigator.serviceWorker.register("/currency-calculator/sw.js").catch(() => {
        /* calculator still works with localStorage rate cache */
      });
    }
  }, []);

  async function refresh(force: boolean) {
    setBusy(true);
    setError(null);
    try {
      const [nextFiat, nextCrypto] = await Promise.all([
        loadFiatRates({ force }),
        loadCryptoRates({ force }).catch(() => cachedCryptoRates()),
      ]);
      setFiat(nextFiat);
      if (nextCrypto) setCrypto(nextCrypto);
      const usingCache = nextFiat.source === "cache" || !navigator.onLine;
      setOffline(usingCache);
      setStatus(
        usingCache
          ? `Offline rates · last updated ${formatUpdatedAt(nextFiat.updatedAt)}`
          : `Live interbank rates · updated ${formatUpdatedAt(nextFiat.updatedAt)}`
      );
    } catch (err) {
      const cached = cachedFiatRates();
      if (cached) {
        setFiat(cached);
        setOffline(true);
        setStatus(`Offline rates · last updated ${formatUpdatedAt(cached.updatedAt)}`);
      }
      setError(err instanceof Error ? err.message : "Could not refresh exchange rates.");
    } finally {
      setBusy(false);
    }
  }

  useEffect(() => {
    void refresh(false);
    function onOnline() {
      setOffline(false);
      void refresh(false);
    }
    function onOffline() {
      setOffline(true);
    }
    window.addEventListener("online", onOnline);
    window.addEventListener("offline", onOffline);
    return () => {
      window.removeEventListener("online", onOnline);
      window.removeEventListener("offline", onOffline);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    writeSavedPair({
      mode,
      from,
      to: destinations[0] ?? "EUR",
      destinations,
      amount,
    });
  }, [mode, from, destinations, amount]);

  useEffect(() => {
    const dialog = dialogRef.current;
    if (!dialog) return;
    if (picker && !dialog.open) dialog.showModal();
    if (!picker && dialog.open) dialog.close();
  }, [picker]);

  const fiatCodes = useMemo(() => {
    const listed = sortCodes(Object.keys(fiat?.rates ?? { USD: 1, EUR: 1, PHP: 1, VND: 1, JPY: 1, MXN: 1 }), FEATURED_FIAT);
    return listed.filter((code) => !isExcludedCurrency(code, fiatName(code)));
  }, [fiat]);

  const cryptoCodes = useMemo(() => {
    const keys = Object.keys(crypto?.rates ?? {});
    const listed = FEATURED_CRYPTO.filter((code) => keys.length === 0 || keys.includes(code));
    const extras = keys.filter(
      (code) => !FEATURED_CRYPTO.includes(code) && code !== "USD" && !FEATURED_FIAT.includes(code) && !isExcludedCurrency(code)
    );
    return [...listed, ...extras.sort()];
  }, [crypto]);

  useEffect(() => {
    if (fiatCodes.length < DESTINATION_COUNT) return;
    setDestinations((current) => {
      const filled = fillDestinations(mode === "fiat" ? from : "USD", current, fiatCodes);
      return filled.join() === current.join() ? current : filled;
    });
  }, [fiatCodes, from, mode]);

  const fromIsCrypto = mode === "crypto";

  function quote(code: string): number | null {
    const value = parseAmount(amount);
    if (value == null || !fiat) return null;
    if (mode === "fiat") return convertFiat(value, from, code, fiat.rates);
    if (!crypto) return null;
    return convertCryptoToFiat(value, from, code, crypto.rates, fiat.rates);
  }

  function unitQuote(code: string): number | null {
    if (!fiat) return null;
    if (mode === "fiat") return convertFiat(1, from, code, fiat.rates);
    if (!crypto) return null;
    return convertCryptoToFiat(1, from, code, crypto.rates, fiat.rates);
  }

  function formatQuote(value: number | null, code: string): string {
    if (value == null) return "—";
    return formatFiat(value, code);
  }

  function applyKey(key: string) {
    setAmount((current) => {
      if (key === "⌫") return current.slice(0, -1);
      if (key === "." && current.includes(".")) return current;
      if (current === "0" && key !== ".") return key;
      if (current.length >= 16) return current;
      return current + key;
    });
  }

  function switchMode(next: Mode) {
    if (next === "fiat") {
      const base = fiatCodes.includes(from) && !isExcludedCurrency(from) ? from : "USD";
      setMode("fiat");
      setFrom(base);
      setDestinations((current) => fillDestinations(base, current, fiatCodes));
      return;
    }
    setMode("crypto");
    setFrom(cryptoCodes.includes(from) ? from : "BTC");
    setDestinations((current) => fillDestinations("XXX", current, fiatCodes));
  }

  function swapWithFirst() {
    if (mode !== "fiat") return;
    const first = destinations[0];
    if (!first || first === from) return;
    setDestinations((current) => {
      const next = [...current];
      next[0] = from;
      return fillDestinations(first, next, fiatCodes);
    });
    setFrom(first);
  }

  const pickerIsCrypto = picker?.kind === "base" && fromIsCrypto;
  const occupied = new Set<string>();
  if (picker?.kind === "row") {
    occupied.add(from.toUpperCase());
    destinations.forEach((code, index) => {
      if (index !== picker.index) occupied.add(code.toUpperCase());
    });
  } else if (picker?.kind === "base" && !pickerIsCrypto) {
    destinations.forEach((code) => occupied.add(code.toUpperCase()));
  }

  const pickerCodes = (pickerIsCrypto ? cryptoCodes : fiatCodes).filter((code) => {
    if (isExcludedCurrency(code, pickerIsCrypto ? cryptoName(code) : fiatName(code))) return false;
    const current =
      picker?.kind === "base" ? from : picker?.kind === "row" ? destinations[picker.index] : "";
    if (code === current) return true;
    if (picker?.kind === "base" && !pickerIsCrypto && occupied.has(code)) return true;
    return !occupied.has(code);
  });

  const pickerOptions = pickerCodes.filter((code) => {
    const label = pickerIsCrypto ? cryptoName(code) : fiatName(code);
    const q = query.trim().toLowerCase();
    if (!q) return true;
    if (q.includes("israel") || q.includes("shekel") || q === "ils" || q === "nis") return false;
    return code.toLowerCase().includes(q) || label.toLowerCase().includes(q);
  });

  function choose(code: string) {
    if (isExcludedCurrency(code, pickerIsCrypto ? cryptoName(code) : fiatName(code))) return;
    if (picker?.kind === "base") {
      if (!pickerIsCrypto && destinations.includes(code)) {
        setDestinations((current) => {
          const next = current.map((item) => (item === code ? from : item));
          return fillDestinations(code, next, fiatCodes);
        });
      }
      setFrom(code);
    } else if (picker?.kind === "row") {
      const index = picker.index;
      if (code === from || destinations.some((item, i) => i !== index && item === code)) return;
      setDestinations((current) => current.map((item, i) => (i === index ? code : item)));
    }
    setPicker(null);
    setQuery("");
  }

  const pickerTitle = pickerIsCrypto
    ? "Choose a cryptocurrency"
    : picker?.kind === "base"
      ? "Choose base currency"
      : "Choose a destination currency";

  return (
    <section className="fx-wrap">
      <form
        className="fx-card"
        onSubmit={(event) => event.preventDefault()}
        aria-labelledby={`${formId}-title`}
      >
        <p className="fx-kicker">Tripmetic</p>
        <h1 id={`${formId}-title`}>Currency calculator</h1>
        <p className="fx-lead">
          Enter an amount in one base currency and see it in five other currencies,
          using the same interbank rates as the Tripmetic app. Rates stay on this
          device after the first download so the calculator still works without Wi-Fi.
        </p>

        <fieldset className="fx-mode">
          <legend className="visually-hidden">Converter type</legend>
          <label>
            <input
              type="radio"
              name="mode"
              value="fiat"
              checked={mode === "fiat"}
              onChange={() => switchMode("fiat")}
            />
            Fiat
          </label>
          <label>
            <input
              type="radio"
              name="mode"
              value="crypto"
              checked={mode === "crypto"}
              onChange={() => switchMode("crypto")}
            />
            Crypto
          </label>
        </fieldset>

        <div className="fx-base">
          <div>
            <span className="fx-label" id={`${formId}-from-label`}>
              {fromIsCrypto ? "Base crypto" : "Base currency"}
            </span>
            <button
              type="button"
              className="fx-select"
              aria-labelledby={`${formId}-from-label`}
              onClick={() => {
                setQuery("");
                setPicker({ kind: "base" });
              }}
            >
              <span aria-hidden="true">{fromIsCrypto ? "₿" : flagEmoji(from)}</span>
              <span>
                <strong>{from}</strong>
                <small>{fromIsCrypto ? cryptoName(from) : fiatName(from)}</small>
              </span>
            </button>
          </div>
          <div>
            <label htmlFor={`${formId}-amount`}>Amount</label>
            <input
              id={`${formId}-amount`}
              name="amount"
              inputMode="decimal"
              enterKeyHint="done"
              autoComplete="off"
              value={amount}
              onChange={(event) => {
                const next = event.target.value.replace(/[^\d.]/g, "");
                const parts = next.split(".");
                setAmount(parts.length > 2 ? `${parts[0]}.${parts.slice(1).join("")}` : next);
              }}
            />
          </div>
        </div>

        {mode === "fiat" && (
          <button type="button" className="fx-swap" onClick={swapWithFirst} aria-label="Swap base with the first destination">
            <span className="visually-hidden">Swap base with the first destination</span>
            ⇄
          </button>
        )}

        <div className="fx-board">
          <span className="fx-label" id={`${formId}-rows-label`}>
            Other currencies
          </span>
          <ul aria-labelledby={`${formId}-rows-label`}>
            {destinations.map((code, index) => {
              const converted = quote(code);
              const unit = unitQuote(code);
              return (
                <li key={`${code}-${index}`} className="fx-row">
                  <button
                    type="button"
                    className="fx-select"
                    aria-label={`Change destination currency ${index + 1}, currently ${fiatName(code)}`}
                    onClick={() => {
                      setQuery("");
                      setPicker({ kind: "row", index });
                    }}
                  >
                    <span aria-hidden="true">{flagEmoji(code)}</span>
                    <span>
                      <strong>{code}</strong>
                      <small>{fiatName(code)}</small>
                    </span>
                  </button>
                  <p className="fx-result" aria-live="polite">
                    <span>{formatQuote(converted, code)}</span>
                    <small>{code}</small>
                  </p>
                  {unit != null && (
                    <p className="fx-row-rate">
                      1 {from} = {formatFiat(unit, code)} {code}
                    </p>
                  )}
                </li>
              );
            })}
          </ul>
        </div>

        <div className="fx-keypad" role="group" aria-label="Numeric keypad">
          {KEYS.map((key) => (
            <button key={key} type="button" onClick={() => applyKey(key)}>
              {key === "⌫" ? <span className="visually-hidden">Backspace</span> : null}
              {key}
            </button>
          ))}
          <button type="button" className="fx-clear" onClick={() => setAmount("")}>
            Clear
          </button>
        </div>

        <div className="fx-status">
          <p>
            <span className={offline ? "fx-dot is-offline" : "fx-dot"} aria-hidden="true" />
            {status}
          </p>
          <button type="button" onClick={() => void refresh(true)} disabled={busy}>
            {busy ? "Refreshing…" : "Refresh rates"}
          </button>
        </div>
        {error && (
          <p className="fx-error" role="alert">
            {error}
          </p>
        )}
        <p className="fx-note">
          Tripmetic shows the interbank rate — the baseline market value. ATMs,
          exchange booths, and card processors add their own spread. Open this
          page on hotel Wi-Fi before you head out to cache the latest rates.
        </p>
      </form>

      <dialog
        ref={dialogRef}
        className="fx-dialog"
        onClose={() => {
          setPicker(null);
          setQuery("");
        }}
        aria-labelledby={`${formId}-picker-title`}
      >
        <div className="fx-dialog-head">
          <h2 id={`${formId}-picker-title`}>{pickerTitle}</h2>
          <button type="button" onClick={() => dialogRef.current?.close()}>
            Close
          </button>
        </div>
        <label htmlFor={searchId}>Search</label>
        <input
          id={searchId}
          name="currency-search"
          type="search"
          value={query}
          onChange={(event) => setQuery(event.target.value)}
          autoComplete="off"
          enterKeyHint="search"
        />
        <ul>
          {pickerOptions.map((code) => {
            const replacesBase = picker?.kind === "base" && !pickerIsCrypto && destinations.includes(code);
            return (
              <li key={code}>
                <button type="button" onClick={() => choose(code)}>
                  <span aria-hidden="true">{pickerIsCrypto ? "₿" : flagEmoji(code)}</span>
                  <span>
                    <strong>{code}</strong>
                    <small>
                      {pickerIsCrypto ? cryptoName(code) : fiatName(code)}
                      {replacesBase ? " · swaps with base" : ""}
                    </small>
                  </span>
                </button>
              </li>
            );
          })}
        </ul>
      </dialog>
    </section>
  );
}
