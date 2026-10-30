"use client";

import { FormEvent, useState } from "react";
import { httpsCallable } from "firebase/functions";
import { AdminShell } from "@/components/AdminShell";
import { getFirebaseFunctions } from "@/lib/firebase";

export default function AdminPushPage() {
  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    if (!confirm("Broadcast this notification to all_users?")) return;
    setBusy(true);
    setMessage(null);
    setError(null);
    try {
      const fn = httpsCallable(getFirebaseFunctions(), "broadcastPush");
      const result = await fn({ title: title.trim(), body: body.trim() });
      const data = result.data as { messageId: string };
      setMessage(`Sent. Message ID: ${data.messageId}`);
      setTitle("");
      setBody("");
    } catch (err: unknown) {
      const msg =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Broadcast failed.";
      setError(msg);
    } finally {
      setBusy(false);
    }
  }

  return (
    <AdminShell title="Push Notification Center">
      <form
        onSubmit={onSubmit}
        className="max-w-xl rounded-2xl border border-black/5 bg-white p-6 shadow-sm"
      >
        <label className="block text-sm font-medium">
          Notification Title
          <input
            required
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
          />
        </label>
        <label className="mt-4 block text-sm font-medium">
          Notification Body / Message
          <textarea
            required
            rows={4}
            value={body}
            onChange={(e) => setBody(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
          />
        </label>
        <button
          type="submit"
          disabled={busy}
          className="mt-6 rounded-lg bg-[#0B132B] px-4 py-3 text-sm font-semibold text-white disabled:opacity-50"
        >
          {busy ? "Sending…" : "Broadcast to All Users"}
        </button>
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
          Sends to FCM topic <code>all_users</code>. Devices subscribe after
          sign-in (iOS needs Push + notification permission). A Message ID means
          FCM accepted the send — not that subscribers exist.
        </p>
      </form>
    </AdminShell>
  );
}
