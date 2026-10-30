"use client";

import Link from "next/link";
import { AdminShell } from "@/components/AdminShell";

const cards = [
  {
    href: "/admin/announcements/",
    title: "Announcements",
    body: "Edit the Settings “Latest updates” card with per-language HTML (bold, links, etc.).",
  },
  {
    href: "/admin/codes/",
    title: "Promo Code Engine",
    body: "Generate lifetime deal codes for AppSumo, PitchGround, and Dealify.",
  },
  {
    href: "/admin/users/",
    title: "Users & Entitlements",
    body: "Search users and grant Tripmetic Pro lifetime access.",
  },
  {
    href: "/admin/push/",
    title: "Push Notification Center",
    body: "Broadcast a message to all devices subscribed to all_users.",
  },
];

export default function AdminHomePage() {
  return (
    <AdminShell title="Overview">
      <div className="grid gap-4 md:grid-cols-3">
        {cards.map((card) => (
          <Link
            key={card.href}
            href={card.href}
            className="rounded-2xl border border-black/5 bg-white p-5 shadow-sm transition hover:border-[#D4AF37]/50 hover:shadow-md"
          >
            <h3 className="text-lg font-semibold text-[#0B132B]">
              {card.title}
            </h3>
            <p className="mt-2 text-sm text-[#607D8B]">{card.body}</p>
          </Link>
        ))}
      </div>
    </AdminShell>
  );
}
