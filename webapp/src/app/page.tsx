import Link from "next/link";

export default function HomePage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-6 bg-[#0B132B] px-6 text-center text-white">
      <p className="text-sm uppercase tracking-[0.25em] text-[#D4AF37]">
        Tripmetic
      </p>
      <h1 className="text-3xl font-semibold">Web tools</h1>
      <div className="flex flex-wrap justify-center gap-3">
        <Link
          href="/redeem/"
          className="rounded-lg bg-[#D4AF37] px-5 py-3 font-semibold text-[#0B132B]"
        >
          Redeem lifetime code
        </Link>
        <Link
          href="/admin/"
          className="rounded-lg border border-white/30 px-5 py-3 font-semibold text-white"
        >
          Super Admin
        </Link>
      </div>
    </main>
  );
}
