"use client";

import { FormEvent, useCallback, useEffect, useMemo, useState } from "react";
import { doc, getDoc, serverTimestamp, setDoc } from "firebase/firestore";
import { AdminShell } from "@/components/AdminShell";
import { getFirebaseAuth, getFirebaseDb } from "@/lib/firebase";

const LOCALES: { code: string; label: string }[] = [
  { code: "en", label: "English" },
  { code: "es", label: "Español" },
  { code: "zh", label: "简体中文" },
  { code: "de", label: "Deutsch" },
  { code: "fr", label: "Français" },
  { code: "ja", label: "日本語" },
  { code: "pt", label: "Português" },
  { code: "ko", label: "한국어" },
  { code: "hi", label: "हिन्दी" },
  { code: "ar", label: "العربية" },
];

const DEFAULT_EN =
  "<p>Welcome to <b>Tripmetic</b>! Check out our new multi-currency budget tool.</p>";

function emptyByLocale(): Record<string, string> {
  const out: Record<string, string> = {};
  for (const { code } of LOCALES) out[code] = "";
  return out;
}

export default function AdminAnnouncementsPage() {
  const [byLocale, setByLocale] = useState<Record<string, string>>(emptyByLocale);
  const [activeLocale, setActiveLocale] = useState("en");
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const snap = await getDoc(doc(getFirebaseDb(), "app_config", "announcements"));
      const next = emptyByLocale();
      if (snap.exists()) {
        const data = snap.data();
        const map = data?.html_by_locale;
        if (map && typeof map === "object") {
          for (const { code } of LOCALES) {
            const v = (map as Record<string, unknown>)[code];
            if (typeof v === "string") next[code] = v;
          }
        }
        const legacy = data?.html_content;
        if (typeof legacy === "string" && legacy.trim() && !next.en.trim()) {
          next.en = legacy;
        }
      }
      if (!next.en.trim()) next.en = DEFAULT_EN;
      setByLocale(next);
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Could not load announcements.";
      setError(msg);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    void load();
  }, [load]);

  const activeHtml = byLocale[activeLocale] ?? "";
  const previewHtml = useMemo(
    () => activeHtml.trim() || "<p><i>(empty — app will fall back to English)</i></p>",
    [activeHtml],
  );

  function setActiveHtml(value: string) {
    setByLocale((prev) => ({ ...prev, [activeLocale]: value }));
  }

  function copyFromEnglish() {
    if (activeLocale === "en") return;
    setByLocale((prev) => ({ ...prev, [activeLocale]: prev.en ?? "" }));
  }

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    setBusy(true);
    setMessage(null);
    setError(null);
    try {
      const html_by_locale: Record<string, string> = {};
      for (const { code } of LOCALES) {
        html_by_locale[code] = (byLocale[code] ?? "").trim();
      }
      if (!html_by_locale.en) {
        setError("English announcement cannot be empty (used as fallback).");
        setBusy(false);
        return;
      }
      const email = getFirebaseAuth().currentUser?.email ?? "";
      await setDoc(
        doc(getFirebaseDb(), "app_config", "announcements"),
        {
          html_content: html_by_locale.en,
          html_by_locale,
          updatedAt: serverTimestamp(),
          updatedBy: email,
        },
        { merge: true },
      );
      setMessage("Announcement saved. The app updates in real time for signed-in users.");
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Save failed.";
      setError(msg);
    } finally {
      setBusy(false);
    }
  }

  return (
    <AdminShell title="Announcements">
      <form
        onSubmit={onSubmit}
        className="mx-auto max-w-3xl space-y-5 rounded-2xl border border-black/5 bg-white p-6 shadow-sm"
      >
        <p className="text-sm text-[#607D8B]">
          Edits the Settings → <strong>Latest updates</strong> card. Use simple HTML:{" "}
          <code className="rounded bg-black/5 px-1">&lt;b&gt;</code>,{" "}
          <code className="rounded bg-black/5 px-1">&lt;i&gt;</code>,{" "}
          <code className="rounded bg-black/5 px-1">&lt;u&gt;</code>,{" "}
          <code className="rounded bg-black/5 px-1">&lt;a href=&quot;…&quot;&gt;</code>,{" "}
          <code className="rounded bg-black/5 px-1">&lt;p&gt;</code>, lists. Empty locales fall
          back to English.
        </p>

        <div className="flex flex-wrap gap-2">
          {LOCALES.map((loc) => {
            const filled = Boolean((byLocale[loc.code] ?? "").trim());
            const active = activeLocale === loc.code;
            return (
              <button
                key={loc.code}
                type="button"
                onClick={() => setActiveLocale(loc.code)}
                className={`rounded-full px-3 py-1.5 text-xs font-semibold transition ${
                  active
                    ? "bg-[#0B132B] text-white"
                    : filled
                      ? "bg-[#D4AF37]/25 text-[#0B132B] hover:bg-[#D4AF37]/40"
                      : "bg-black/5 text-[#607D8B] hover:bg-black/10"
                }`}
              >
                {loc.code.toUpperCase()}
                <span className="ml-1 font-normal opacity-80">{loc.label}</span>
              </button>
            );
          })}
        </div>

        {loading ? (
          <p className="text-sm text-[#607D8B]">Loading…</p>
        ) : (
          <>
            <div className="flex flex-wrap items-center justify-between gap-2">
              <label className="text-sm font-medium">
                HTML — {LOCALES.find((l) => l.code === activeLocale)?.label} ({activeLocale})
              </label>
              {activeLocale !== "en" && (
                <button
                  type="button"
                  onClick={copyFromEnglish}
                  className="rounded-md border border-black/10 px-2 py-1 text-xs font-medium text-[#0B132B] hover:bg-black/5"
                >
                  Copy from English
                </button>
              )}
            </div>
            <textarea
              rows={8}
              value={activeHtml}
              onChange={(e) => setActiveHtml(e.target.value)}
              spellCheck={false}
              className="w-full rounded-lg border border-black/10 px-3 py-2 font-mono text-sm"
              placeholder='<p>Welcome to <b>Tripmetic</b>! <a href="https://tripmetic.app">Learn more</a>.</p>'
            />

            <div>
              <p className="mb-2 text-sm font-medium">Preview</p>
              <div
                className="rounded-xl border border-[#D4AF37]/50 bg-[#D4AF37]/10 px-4 py-3 text-sm leading-relaxed text-[#0B132B] [&_a]:font-semibold [&_a]:text-[#0B132B] [&_a]:underline"
                dangerouslySetInnerHTML={{ __html: previewHtml }}
              />
            </div>
          </>
        )}

        <div className="flex flex-wrap gap-3">
          <button
            type="submit"
            disabled={busy || loading}
            className="rounded-lg bg-[#0B132B] px-4 py-3 text-sm font-semibold text-white disabled:opacity-50"
          >
            {busy ? "Saving…" : "Save announcements"}
          </button>
          <button
            type="button"
            disabled={busy || loading}
            onClick={() => void load()}
            className="rounded-lg border border-black/10 px-4 py-3 text-sm font-semibold text-[#0B132B] disabled:opacity-50"
          >
            Reload
          </button>
        </div>

        {message && (
          <p className="rounded-lg bg-emerald-50 px-3 py-2 text-sm text-emerald-800">
            {message}
          </p>
        )}
        {error && (
          <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">{error}</p>
        )}
      </form>
    </AdminShell>
  );
}
