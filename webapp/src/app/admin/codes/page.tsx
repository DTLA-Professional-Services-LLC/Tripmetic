"use client";

import { useState } from "react";
import { httpsCallable } from "firebase/functions";
import { AdminShell } from "@/components/AdminShell";
import { getFirebaseFunctions } from "@/lib/firebase";

const BATCHES = [500, 1000, 2000] as const;

function downloadCsv(codes: string[], campaign: string) {
  const blob = new Blob([codes.join("\n") + "\n"], {
    type: "text/csv;charset=utf-8",
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${campaign || "appsumo"}_codes.csv`;
  a.click();
  URL.revokeObjectURL(url);
}

export default function AdminCodesPage() {
  const [campaign, setCampaign] = useState("AppSumo_Tier1");
  const [entitlementType, setEntitlementType] = useState("Tripmetic Pro");
  const [busy, setBusy] = useState<number | null>(null);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function generate(count: number) {
    setBusy(count);
    setMessage(null);
    setError(null);
    try {
      const fn = httpsCallable(getFirebaseFunctions(), "generatePromoCodes");
      const result = await fn({
        count,
        campaign: campaign.trim(),
        entitlement_type: entitlementType,
      });
      const data = result.data as {
        codes: string[];
        count: number;
        campaign: string;
      };
      downloadCsv(data.codes, data.campaign);
      setMessage(`Generated ${data.count} codes and downloaded CSV.`);
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Generation failed.";
      setError(msg);
    } finally {
      setBusy(null);
    }
  }

  return (
    <AdminShell title="Promo Code Engine">
      <section className="max-w-2xl rounded-2xl border border-black/5 bg-white p-6 shadow-sm">
        <label className="block text-sm font-medium">
          Campaign Name
          <input
            value={campaign}
            onChange={(e) => setCampaign(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
            placeholder="AppSumo_Tier1"
          />
        </label>
        <label className="mt-4 block text-sm font-medium">
          Entitlement Type
          <select
            value={entitlementType}
            onChange={(e) => setEntitlementType(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
          >
            <option value="Tripmetic Pro">Tripmetic Pro (lifetime)</option>
          </select>
        </label>

        <div className="mt-6 flex flex-wrap gap-3">
          {BATCHES.map((count) => (
            <button
              key={count}
              type="button"
              disabled={busy !== null}
              onClick={() => generate(count)}
              className="rounded-lg bg-[#0B132B] px-4 py-2 text-sm font-semibold text-white disabled:opacity-50"
            >
              {busy === count ? "Generating…" : `Generate ${count.toLocaleString()}`}
            </button>
          ))}
        </div>

        {message && (
          <p className="mt-4 rounded-lg bg-emerald-50 px-3 py-2 text-sm text-emerald-800">
            {message}
          </p>
        )}
        {error && (
          <p className="mt-4 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
            {error}
          </p>
        )}
        <p className="mt-4 text-xs text-[#607D8B]">
          Codes use the format TRIPMETIC-XXXX-XXXX-XXXX and are written to the
          Firestore <code>appsumo_codes</code> collection.
        </p>
      </section>
    </AdminShell>
  );
}
