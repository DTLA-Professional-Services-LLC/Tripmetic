"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { httpsCallable } from "firebase/functions";
import { AdminShell } from "@/components/AdminShell";
import { getFirebaseFunctions } from "@/lib/firebase";

type UserRow = {
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

type UserStats = {
  total: number;
  free: number;
  premium: number;
  banned: number;
  byPlatform: Record<string, number>;
};

type SortField =
  | "uid"
  | "email"
  | "displayName"
  | "createdAt"
  | "lastLoginAt"
  | "entitlement_status"
  | "platform"
  | "banned"
  | "lifetime_access";

type ListUsersResponse = {
  users: UserRow[];
  stats: UserStats;
  rangeStats: UserStats;
  matched: number;
  returned: number;
};

const emptyStats: UserStats = {
  total: 0,
  free: 0,
  premium: 0,
  banned: 0,
  byPlatform: {},
};

function csvEscape(value: string) {
  if (/[",\n]/.test(value)) return `"${value.replace(/"/g, '""')}"`;
  return value;
}

function downloadCsv(filename: string, rows: string[][]) {
  const content = rows.map((r) => r.map((c) => csvEscape(c)).join(",")).join("\n");
  const blob = new Blob([content], { type: "text/csv;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}

function platformLabel(platform: string) {
  const p = (platform || "unknown").toLowerCase();
  if (p === "ios") return "iOS";
  if (p === "android") return "Android";
  if (p === "web") return "Web";
  if (p === "macos") return "macOS";
  if (p === "windows") return "Windows";
  if (p === "linux") return "Linux";
  return p || "Unknown";
}

function formatDate(iso: string | null) {
  if (!iso) return "—";
  try {
    return new Date(iso).toLocaleDateString();
  } catch {
    return "—";
  }
}

export default function AdminUsersPage() {
  const [search, setSearch] = useState("");
  const [status, setStatus] = useState("all");
  const [createdFrom, setCreatedFrom] = useState("");
  const [createdTo, setCreatedTo] = useState("");
  const [sortBy, setSortBy] = useState<SortField>("createdAt");
  const [sortDir, setSortDir] = useState<"asc" | "desc">("desc");
  const [users, setUsers] = useState<UserRow[]>([]);
  const [stats, setStats] = useState<UserStats>(emptyStats);
  const [rangeStats, setRangeStats] = useState<UserStats>(emptyStats);
  const [matched, setMatched] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busyUid, setBusyUid] = useState<string | null>(null);
  const [message, setMessage] = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const fn = httpsCallable(getFirebaseFunctions(), "listUsers");
      const result = await fn({
        search,
        limit: 2000,
        sortBy,
        sortDir,
        status,
        createdFrom: createdFrom ? new Date(`${createdFrom}T00:00:00`).toISOString() : null,
        createdTo: createdTo ? new Date(`${createdTo}T23:59:59.999`).toISOString() : null,
      });
      const data = result.data as ListUsersResponse;
      setUsers(data.users ?? []);
      setStats(data.stats ?? emptyStats);
      setRangeStats(data.rangeStats ?? emptyStats);
      setMatched(data.matched ?? data.users?.length ?? 0);
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Failed to load users.";
      setError(msg);
    } finally {
      setLoading(false);
    }
  }, [search, sortBy, sortDir, status, createdFrom, createdTo]);

  useEffect(() => {
    void load();
  }, [load]);

  function toggleSort(field: SortField) {
    if (sortBy === field) {
      setSortDir((d) => (d === "asc" ? "desc" : "asc"));
    } else {
      setSortBy(field);
      setSortDir(field === "createdAt" || field === "lastLoginAt" ? "desc" : "asc");
    }
  }

  function sortMarker(field: SortField) {
    if (sortBy !== field) return "";
    return sortDir === "asc" ? " ↑" : " ↓";
  }

  async function runAction(
    uid: string,
    name: string,
    confirmText: string,
    callable: string,
    payload: Record<string, unknown> = {}
  ) {
    if (!confirm(confirmText)) return;
    setBusyUid(uid);
    setError(null);
    setMessage(null);
    try {
      const fn = httpsCallable(getFirebaseFunctions(), callable);
      await fn({ uid, ...payload });
      setMessage(`${name} succeeded.`);
      await load();
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : `${name} failed.`;
      setError(msg);
    } finally {
      setBusyUid(null);
    }
  }

  function exportCsv(scope: "visible" | "report") {
    const stamp = new Date().toISOString().slice(0, 10);
    const header = [
      "uid",
      "email",
      "displayName",
      "createdAt",
      "lastLoginAt",
      "platform",
      "platformVersion",
      "entitlement_status",
      "lifetime_access",
      "isPremium",
      "banned",
      "banReason",
    ];
    const body = users.map((u) => [
      u.uid,
      u.email,
      u.displayName,
      u.createdAt ?? "",
      u.lastLoginAt ?? "",
      u.platform,
      u.platformVersion,
      u.entitlement_status,
      String(u.lifetime_access),
      String(u.isPremium),
      String(u.banned),
      u.banReason,
    ]);
    const prefix = scope === "report" ? "tripmetic-user-report" : "tripmetic-users";
    const range =
      createdFrom || createdTo
        ? `_${createdFrom || "start"}_to_${createdTo || "end"}`
        : "";
    downloadCsv(`${prefix}${range}_${stamp}.csv`, [header, ...body]);
  }

  const platformSummary = useMemo(() => {
    const entries = Object.entries(stats.byPlatform || {}).sort((a, b) => b[1] - a[1]);
    if (entries.length === 0) return "No device data yet";
    return entries.map(([k, v]) => `${platformLabel(k)} ${v}`).join(" · ");
  }, [stats.byPlatform]);

  return (
    <AdminShell title="Users & Entitlements">
      <div className="mb-6 grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <StatCard label="Total users" value={stats.total} />
        <StatCard label="Free" value={stats.free} tone="slate" />
        <StatCard label="Premium" value={stats.premium} tone="emerald" />
        <StatCard label="Banned" value={stats.banned} tone="rose" />
      </div>
      <p className="mb-6 text-sm text-[#607D8B]">Devices: {platformSummary}</p>

      <div className="mb-4 grid gap-3 rounded-2xl border border-black/5 bg-white p-4 shadow-sm lg:grid-cols-6">
        <label className="text-sm lg:col-span-2">
          <span className="mb-1 block text-xs font-semibold uppercase tracking-wide text-[#607D8B]">
            Search
          </span>
          <input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Email, name, uid, or device"
            className="w-full rounded-lg border border-black/10 bg-white px-3 py-2"
          />
        </label>
        <label className="text-sm">
          <span className="mb-1 block text-xs font-semibold uppercase tracking-wide text-[#607D8B]">
            Status
          </span>
          <select
            value={status}
            onChange={(e) => setStatus(e.target.value)}
            className="w-full rounded-lg border border-black/10 bg-white px-3 py-2"
          >
            <option value="all">All</option>
            <option value="free">Free</option>
            <option value="premium">Premium</option>
            <option value="lifetime">Lifetime</option>
            <option value="banned">Banned</option>
          </select>
        </label>
        <label className="text-sm">
          <span className="mb-1 block text-xs font-semibold uppercase tracking-wide text-[#607D8B]">
            From
          </span>
          <input
            type="date"
            value={createdFrom}
            onChange={(e) => setCreatedFrom(e.target.value)}
            className="w-full rounded-lg border border-black/10 bg-white px-3 py-2"
          />
        </label>
        <label className="text-sm">
          <span className="mb-1 block text-xs font-semibold uppercase tracking-wide text-[#607D8B]">
            To
          </span>
          <input
            type="date"
            value={createdTo}
            onChange={(e) => setCreatedTo(e.target.value)}
            className="w-full rounded-lg border border-black/10 bg-white px-3 py-2"
          />
        </label>
        <div className="flex items-end gap-2">
          <button
            type="button"
            onClick={() => void load()}
            className="w-full rounded-lg bg-[#0B132B] px-4 py-2 text-sm font-semibold text-white"
          >
            Run report
          </button>
        </div>
      </div>

      {(createdFrom || createdTo || status !== "all" || search) && (
        <p className="mb-3 text-sm text-[#607D8B]">
          Report match: <strong>{matched}</strong> users · free{" "}
          <strong>{rangeStats.free}</strong> · premium{" "}
          <strong>{rangeStats.premium}</strong> · banned{" "}
          <strong>{rangeStats.banned}</strong>
        </p>
      )}

      <div className="mb-4 flex flex-wrap gap-2">
        <button
          type="button"
          onClick={() => exportCsv("visible")}
          className="rounded-lg border border-black/10 bg-white px-3 py-2 text-sm font-semibold"
        >
          Download CSV
        </button>
        <button
          type="button"
          onClick={() => exportCsv("report")}
          className="rounded-lg border border-[#D4AF37]/40 bg-[#D4AF37]/15 px-3 py-2 text-sm font-semibold text-[#0B132B]"
        >
          Download report CSV
        </button>
        <button
          type="button"
          onClick={() => {
            setSearch("");
            setStatus("all");
            setCreatedFrom("");
            setCreatedTo("");
            setSortBy("createdAt");
            setSortDir("desc");
          }}
          className="rounded-lg px-3 py-2 text-sm font-medium text-[#607D8B] hover:bg-black/5"
        >
          Clear filters
        </button>
      </div>

      {error && (
        <p className="mb-4 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
          {error}
        </p>
      )}
      {message && (
        <p className="mb-4 rounded-lg bg-emerald-50 px-3 py-2 text-sm text-emerald-700">
          {message}
        </p>
      )}

      <div className="overflow-x-auto rounded-2xl border border-black/5 bg-white shadow-sm">
        <table className="min-w-full text-left text-sm">
          <thead className="border-b border-black/5 bg-[#F4F6FA] text-xs uppercase tracking-wide text-[#607D8B]">
            <tr>
              <SortTh label="User ID" onClick={() => toggleSort("uid")} mark={sortMarker("uid")} />
              <SortTh label="Email" onClick={() => toggleSort("email")} mark={sortMarker("email")} />
              <SortTh
                label="Signup"
                onClick={() => toggleSort("createdAt")}
                mark={sortMarker("createdAt")}
              />
              <SortTh
                label="Device"
                onClick={() => toggleSort("platform")}
                mark={sortMarker("platform")}
              />
              <SortTh
                label="Status"
                onClick={() => toggleSort("entitlement_status")}
                mark={sortMarker("entitlement_status")}
              />
              <th className="px-4 py-3">Actions</th>
            </tr>
          </thead>
          <tbody>
            {loading ? (
              <tr>
                <td className="px-4 py-6 text-[#607D8B]" colSpan={6}>
                  Loading…
                </td>
              </tr>
            ) : users.length === 0 ? (
              <tr>
                <td className="px-4 py-6 text-[#607D8B]" colSpan={6}>
                  No users match this report. Profiles appear after redeem / mobile
                  sign-in.
                </td>
              </tr>
            ) : (
              users.map((u) => {
                const busy = busyUid === u.uid;
                return (
                  <tr key={u.uid} className="border-t border-black/5 align-top">
                    <td className="max-w-[140px] truncate px-4 py-3 font-mono text-xs">
                      {u.uid}
                    </td>
                    <td className="px-4 py-3">
                      <div className="font-medium">{u.email || "—"}</div>
                      <div className="text-xs text-[#607D8B]">
                        {u.displayName || "—"}
                      </div>
                    </td>
                    <td className="px-4 py-3 text-[#607D8B]">
                      <div>{formatDate(u.createdAt)}</div>
                      <div className="text-xs">Last: {formatDate(u.lastLoginAt)}</div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="font-medium">{platformLabel(u.platform)}</div>
                      <div className="max-w-[160px] truncate text-xs text-[#607D8B]">
                        {u.platformVersion || "—"}
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex flex-wrap gap-1">
                        <span
                          className={`rounded-full px-2 py-1 text-xs font-semibold ${
                            u.isPremium
                              ? "bg-emerald-50 text-emerald-700"
                              : "bg-slate-100 text-slate-600"
                          }`}
                        >
                          {u.lifetime_access
                            ? "Lifetime"
                            : u.isPremium
                              ? u.entitlement_status || "premium"
                              : "free"}
                        </span>
                        {u.banned && (
                          <span className="rounded-full bg-rose-50 px-2 py-1 text-xs font-semibold text-rose-700">
                            banned
                          </span>
                        )}
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex min-w-[220px] flex-wrap gap-1.5">
                        {!u.lifetime_access ? (
                          <ActionButton
                            disabled={busy}
                            tone="gold"
                            onClick={() =>
                              void runAction(
                                u.uid,
                                "Grant lifetime",
                                "Grant Tripmetic Pro lifetime access to this user?",
                                "grantLifetimeAccess"
                              )
                            }
                          >
                            {busy ? "…" : "Grant lifetime"}
                          </ActionButton>
                        ) : (
                          <ActionButton
                            disabled={busy}
                            tone="slate"
                            onClick={() =>
                              void runAction(
                                u.uid,
                                "Remove lifetime",
                                "Remove promotional lifetime access for this user?",
                                "revokeLifetimeAccess"
                              )
                            }
                          >
                            Remove lifetime
                          </ActionButton>
                        )}
                        {!u.banned ? (
                          <ActionButton
                            disabled={busy}
                            tone="rose"
                            onClick={() => {
                              const reason =
                                window.prompt("Ban reason (optional):", "") ?? "";
                              void runAction(
                                u.uid,
                                "Ban",
                                "Ban this user? They will no longer be able to sign in.",
                                "banUser",
                                { reason }
                              );
                            }}
                          >
                            Ban
                          </ActionButton>
                        ) : (
                          <ActionButton
                            disabled={busy}
                            tone="slate"
                            onClick={() =>
                              void runAction(
                                u.uid,
                                "Unban",
                                "Unban this user and restore sign-in?",
                                "unbanUser"
                              )
                            }
                          >
                            Unban
                          </ActionButton>
                        )}
                        <ActionButton
                          disabled={busy}
                          tone="danger"
                          onClick={() =>
                            void runAction(
                              u.uid,
                              "Delete",
                              "Permanently delete this user account and profile? This cannot be undone.",
                              "deleteUser"
                            )
                          }
                        >
                          Delete
                        </ActionButton>
                      </div>
                    </td>
                  </tr>
                );
              })
            )}
          </tbody>
        </table>
      </div>
    </AdminShell>
  );
}

function StatCard({
  label,
  value,
  tone = "navy",
}: {
  label: string;
  value: number;
  tone?: "navy" | "slate" | "emerald" | "rose";
}) {
  const tones = {
    navy: "bg-[#0B132B] text-white",
    slate: "bg-white text-[#0B132B] border border-black/5",
    emerald: "bg-emerald-50 text-emerald-800 border border-emerald-100",
    rose: "bg-rose-50 text-rose-800 border border-rose-100",
  };
  return (
    <div className={`rounded-2xl px-4 py-4 shadow-sm ${tones[tone]}`}>
      <p className="text-xs font-semibold uppercase tracking-wide opacity-70">
        {label}
      </p>
      <p className="mt-1 text-3xl font-semibold">{value}</p>
    </div>
  );
}

function SortTh({
  label,
  onClick,
  mark,
}: {
  label: string;
  onClick: () => void;
  mark: string;
}) {
  return (
    <th className="px-4 py-3">
      <button
        type="button"
        onClick={onClick}
        className="font-semibold uppercase tracking-wide hover:text-[#0B132B]"
      >
        {label}
        {mark}
      </button>
    </th>
  );
}

function ActionButton({
  children,
  onClick,
  disabled,
  tone,
}: {
  children: React.ReactNode;
  onClick: () => void;
  disabled?: boolean;
  tone: "gold" | "slate" | "rose" | "danger";
}) {
  const tones = {
    gold: "bg-[#D4AF37] text-[#0B132B]",
    slate: "bg-slate-100 text-slate-800",
    rose: "bg-rose-100 text-rose-800",
    danger: "bg-[#0B132B] text-white",
  };
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      className={`rounded-lg px-2.5 py-1.5 text-xs font-semibold disabled:opacity-40 ${tones[tone]}`}
    >
      {children}
    </button>
  );
}
