"use client";

import { FormEvent, useEffect, useState } from "react";
import { onAuthStateChanged, signInWithEmailAndPassword } from "firebase/auth";
import { useRouter, useSearchParams } from "next/navigation";
import { Suspense } from "react";
import { getFirebaseAuth } from "@/lib/firebase";
import { hasAdminClaim } from "@/lib/admin";

function LoginForm() {
  const router = useRouter();
  const params = useSearchParams();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(
    params.get("error") === "unauthorized"
      ? "This account is not authorized for Super Admin."
      : null
  );

  useEffect(() => {
    return onAuthStateChanged(getFirebaseAuth(), (user) => {
      if (!user) return;
      void hasAdminClaim(user)
        .then((isAdmin) => {
          if (isAdmin) router.replace("/admin/");
        })
        .catch(() => undefined);
    });
  }, [router]);

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
      const cred = await signInWithEmailAndPassword(
        getFirebaseAuth(),
        email.trim(),
        password
      );
      if (!(await hasAdminClaim(cred.user))) {
        await getFirebaseAuth().signOut();
        setError("This account is not authorized for Super Admin.");
        return;
      }
      router.replace("/admin/");
    } catch (err: unknown) {
      const code =
        err && typeof err === "object" && "code" in err
          ? String((err as { code: string }).code)
          : "";
      if (
        code === "auth/invalid-credential" ||
        code === "auth/user-not-found" ||
        code === "auth/wrong-password"
      ) {
        setError(
          "Invalid email or password. The account must exist in Firebase Authentication and have the admin custom claim."
        );
      } else {
        const message =
          err && typeof err === "object" && "message" in err
            ? String((err as { message: string }).message)
            : "Sign-in failed.";
        setError(message);
      }
    } finally {
      setBusy(false);
    }
  }

  return (
    <main className="flex min-h-screen items-center justify-center bg-[#0B132B] px-4">
      <form
        onSubmit={onSubmit}
        className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl"
      >
        <p className="text-xs uppercase tracking-[0.2em] text-[#D4AF37]">
          Tripmetic
        </p>
        <h1 className="mt-1 text-2xl font-semibold text-[#0B132B]">
          Super Admin Login
        </h1>
        <label className="mt-6 block text-sm font-medium text-[#0B132B]">
          Email
          <input
            required
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
          />
        </label>
        <label className="mt-4 block text-sm font-medium text-[#0B132B]">
          Password
          <input
            required
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2"
          />
        </label>
        {error && (
          <p className="mt-4 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
            {error}
          </p>
        )}
        <button
          type="submit"
          disabled={busy}
          className="mt-6 w-full rounded-lg bg-[#D4AF37] px-4 py-3 font-semibold text-[#0B132B] disabled:opacity-60"
        >
          {busy ? "Signing in…" : "Sign in"}
        </button>
      </form>
    </main>
  );
}

export default function AdminLoginPage() {
  return (
    <Suspense
      fallback={
        <div className="flex min-h-screen items-center justify-center bg-[#0B132B] text-white">
          Loading…
        </div>
      }
    >
      <LoginForm />
    </Suspense>
  );
}
