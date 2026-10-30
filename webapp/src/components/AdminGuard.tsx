"use client";

import { useEffect, useState, type ReactNode } from "react";
import { onAuthStateChanged } from "firebase/auth";
import { useRouter } from "next/navigation";
import { getFirebaseAuth } from "@/lib/firebase";
import { hasAdminClaim } from "@/lib/admin";

type AccessState = "loading" | "authorized" | "denied" | "signed-out";

export function AdminGuard({ children }: { children: ReactNode }) {
  const router = useRouter();
  const [access, setAccess] = useState<AccessState>("loading");

  useEffect(() => {
    const auth = getFirebaseAuth();
    let active = true;

    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (!active) return;
      if (!user) {
        setAccess("signed-out");
        return;
      }

      setAccess("loading");
      void hasAdminClaim(user)
        .then((isAdmin) => {
          if (active) setAccess(isAdmin ? "authorized" : "denied");
        })
        .catch(() => {
          if (active) setAccess("denied");
        });
    });

    return () => {
      active = false;
      unsubscribe();
    };
  }, []);

  useEffect(() => {
    if (access === "signed-out") {
      router.replace("/admin/login/");
    } else if (access === "denied") {
      router.replace("/admin/login/?error=unauthorized");
    }
  }, [access, router]);

  if (access !== "authorized") {
    return (
      <div className="flex min-h-screen items-center justify-center bg-[#0B132B] text-white">
        {access === "loading" ? "Checking session…" : "Redirecting…"}
      </div>
    );
  }

  return <>{children}</>;
}
