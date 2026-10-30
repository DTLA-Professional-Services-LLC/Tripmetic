"use client";

import { FormEvent, useState } from "react";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  updateProfile,
  type User,
} from "firebase/auth";
import { FirebaseError } from "firebase/app";
import { httpsCallable } from "firebase/functions";
import { SiteFooter } from "@/components/SiteFooter";
import { getFirebaseAuth, getFirebaseFunctions } from "@/lib/firebase";
import { ensureUserProfileDoc } from "@/lib/userProfile";

const IOS_URL = "https://apps.apple.com/us/app/tripmetic/id6765632920";
const ANDROID_URL =
  "https://play.google.com/store/apps/details?id=com.tripmetic.app";

export default function RedeemPage() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [code, setCode] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  async function ensureSignedInUser(): Promise<User> {
    const auth = getFirebaseAuth();
    try {
      const credential = await createUserWithEmailAndPassword(
        auth,
        email.trim(),
        password
      );
      const user = credential.user;
      if (name.trim()) {
        await updateProfile(user, { displayName: name.trim() });
      }
      return user;
    } catch (err) {
      // Account already created (e.g. prior redeem attempt) — sign in and continue.
      if (err instanceof FirebaseError && err.code === "auth/email-already-in-use") {
        const credential = await signInWithEmailAndPassword(
          auth,
          email.trim(),
          password
        );
        return credential.user;
      }
      throw err;
    }
  }

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    setError(null);
    setBusy(true);
    try {
      const user = await ensureSignedInUser();
      await ensureUserProfileDoc(user, name.trim());

      const redeem = httpsCallable(getFirebaseFunctions(), "redeemPromoCode");
      await redeem({ appSumoCode: code.trim() });
      setSuccess(true);
    } catch (err: unknown) {
      const message =
        err && typeof err === "object" && "message" in err
          ? String((err as { message: string }).message)
          : "Something went wrong. Please try again.";
      setError(message.replace(/^Firebase:\s*/i, "").replace(/\(auth\/.*\)\.?/, "").trim() || message);
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="flex min-h-screen flex-col bg-[#0B132B]">
      <main className="flex-1 bg-gradient-to-b from-[#0B132B] via-[#132038] to-[#0B132B] px-4 py-10 text-white">
        <div className="mx-auto w-full max-w-md">
          <div className="mb-8 text-center">
            <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-2xl bg-[#D4AF37]/20 text-2xl font-bold text-[#D4AF37]">
              T
            </div>
            <p className="text-sm uppercase tracking-[0.25em] text-[#D4AF37]">
              Tripmetic
            </p>
            <h1 className="mt-2 text-3xl font-semibold">Redeem your code</h1>
            <p className="mt-2 text-sm text-white/70">
              Create your account, redeem your lifetime deal code, then download
              the app and sign in with the same email.
            </p>
          </div>

          {success ? (
            <div className="rounded-2xl bg-white p-6 text-[#0B132B] shadow-xl">
              <h2 className="text-xl font-semibold text-emerald-700">
                You&apos;re all set
              </h2>
              <p className="mt-2 text-sm text-[#37474F]">
                Lifetime access has been granted. Download Tripmetic and sign in
                with <strong>{email.trim()}</strong> to unlock Pro.
              </p>
              <div className="mt-6 flex flex-col gap-3">
                <a
                  href={IOS_URL}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="rounded-lg bg-[#0B132B] px-4 py-3 text-center font-semibold text-white"
                >
                  Download on the App Store
                </a>
                <a
                  href={ANDROID_URL}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="rounded-lg border border-[#0B132B] px-4 py-3 text-center font-semibold text-[#0B132B]"
                >
                  Get it on Google Play
                </a>
              </div>
            </div>
          ) : (
            <form
              onSubmit={onSubmit}
              className="rounded-2xl bg-white p-6 text-[#0B132B] shadow-xl"
            >
              <label className="mb-4 block text-sm font-medium">
                Name
                <input
                  required
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2 outline-none ring-[#D4AF37] focus:ring-2"
                  autoComplete="name"
                />
              </label>
              <label className="mb-4 block text-sm font-medium">
                Email
                <input
                  required
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2 outline-none ring-[#D4AF37] focus:ring-2"
                  autoComplete="email"
                />
              </label>
              <label className="mb-4 block text-sm font-medium">
                Password
                <input
                  required
                  type="password"
                  minLength={6}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2 outline-none ring-[#D4AF37] focus:ring-2"
                  autoComplete="new-password"
                />
              </label>
              <label className="mb-6 block text-sm font-medium">
                Redeem Code
                <input
                  required
                  value={code}
                  onChange={(e) => setCode(e.target.value)}
                  placeholder="TRIPMETIC-XXXX-XXXX-XXXX"
                  className="mt-1 w-full rounded-lg border border-black/10 px-3 py-2 uppercase outline-none ring-[#D4AF37] focus:ring-2"
                  autoComplete="off"
                />
              </label>

              {error && (
                <p className="mb-4 rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
                  {error}
                </p>
              )}

              <button
                type="submit"
                disabled={busy}
                className="w-full rounded-lg bg-[#D4AF37] px-4 py-3 font-semibold text-[#0B132B] disabled:opacity-60"
              >
                {busy ? "Creating account…" : "Create Account & Redeem"}
              </button>
              <p className="mt-4 text-center text-xs text-[#607D8B]">
                No credit card or phone number required.
              </p>
            </form>
          )}
        </div>
      </main>
      <SiteFooter />
    </div>
  );
}
