"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { signOut } from "firebase/auth";
import { getFirebaseAuth } from "@/lib/firebase";
import { AdminGuard } from "./AdminGuard";

const nav = [
  { href: "/admin/", label: "Overview" },
  { href: "/admin/announcements/", label: "Announcements" },
  { href: "/admin/codes/", label: "Promo Codes" },
  { href: "/admin/users/", label: "Users" },
  { href: "/admin/push/", label: "Push" },
];

export function AdminShell({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  const pathname = usePathname();
  const router = useRouter();

  async function handleSignOut() {
    await signOut(getFirebaseAuth());
    router.replace("/admin/login/");
  }

  return (
    <AdminGuard>
      <div className="flex min-h-screen bg-[#F4F6FA] text-[#0B132B]">
        <aside className="hidden w-64 flex-col bg-[#0B132B] px-5 py-8 text-white md:flex">
          <div className="mb-10">
            <p className="text-xs uppercase tracking-[0.2em] text-[#D4AF37]">
              Tripmetic
            </p>
            <h1 className="mt-1 text-xl font-semibold">Super Admin</h1>
          </div>
          <nav className="flex flex-1 flex-col gap-1">
            {nav.map((item) => {
              const active =
                pathname === item.href ||
                (item.href !== "/admin/" && pathname?.startsWith(item.href));
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`rounded-lg px-3 py-2 text-sm font-medium transition ${
                    active
                      ? "bg-[#D4AF37] text-[#0B132B]"
                      : "text-white/80 hover:bg-white/10 hover:text-white"
                  }`}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>
          <button
            type="button"
            onClick={handleSignOut}
            className="mt-6 rounded-lg border border-white/20 px-3 py-2 text-left text-sm text-white/80 hover:bg-white/10"
          >
            Sign out
          </button>
        </aside>
        <div className="flex min-w-0 flex-1 flex-col">
          <header className="border-b border-black/5 bg-white px-4 py-4 md:px-8">
            <div className="flex items-center justify-between gap-4">
              <h2 className="text-xl font-semibold md:text-2xl">{title}</h2>
              <div className="flex gap-2 md:hidden">
                {nav.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    className="rounded-md bg-[#0B132B] px-2 py-1 text-xs text-white"
                  >
                    {item.label}
                  </Link>
                ))}
              </div>
            </div>
          </header>
          <main className="flex-1 px-4 py-6 md:px-8">{children}</main>
        </div>
      </div>
    </AdminGuard>
  );
}
