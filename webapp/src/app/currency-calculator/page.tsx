import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { CurrencyCalculator } from "@/components/CurrencyCalculator";
import { SiteFooter } from "@/components/SiteFooter";
import { SiteNav } from "@/components/SiteNav";

const inter = Inter({ subsets: ["latin"], display: "swap" });

export const metadata: Metadata = {
  title: "Currency Calculator | Tripmetic",
  description:
    "Travel currency calculator with live and offline exchange rates. Convert prices abroad using the same Tripmetic interbank rates, including crypto to local currency.",
  alternates: { canonical: "https://tripmetic.app/currency-calculator" },
  robots: { index: true, follow: true },
  openGraph: {
    title: "Currency Calculator | Tripmetic",
    description:
      "Convert prices abroad with live and offline Tripmetic exchange rates. No account required.",
    url: "https://tripmetic.app/currency-calculator",
    siteName: "Tripmetic",
    type: "website",
  },
};

const FAQ = [
  {
    q: "How often do the exchange rates update?",
    a: "When this page is online it reads the same Tripmetic rate store the mobile app uses. Tap Refresh rates anytime for the latest numbers. After a successful load, those rates stay on your device.",
  },
  {
    q: "Does the currency converter work offline?",
    a: "Yes. After you open the calculator once while online, the last downloaded rates are cached on this device. If you lose Wi-Fi, the calculator keeps using that last data point.",
  },
  {
    q: "Are these the exact rates I will get at an ATM?",
    a: "Tripmetic provides the interbank exchange rate — the baseline market value. Local ATMs, currency booths, and card processors add their own spread or foreign transaction fees. Use this calculator to check whether a vendor’s markup is fair.",
  },
];

export default function CurrencyCalculatorPage() {
  return (
    <div className={`${inter.className} min-h-screen bg-[#FAF9F6] text-[#37474F]`}>
      <SiteNav />
      <main className="px-4 py-10">
        <CurrencyCalculator />

        <section className="mx-auto mt-10 w-full max-w-[720px]">
          <h2 className="text-2xl font-semibold text-[#0B132B]">Frequently asked questions</h2>
          <div className="mt-4 grid gap-4">
            {FAQ.map((item) => (
              <article key={item.q} className="rounded-2xl border border-black/5 bg-white p-5">
                <h3 className="text-lg font-semibold text-[#0B132B]">{item.q}</h3>
                <p className="mt-2 leading-relaxed">{item.a}</p>
              </article>
            ))}
          </div>

          <div className="mt-8 rounded-2xl border-l-4 border-[#D4AF37] bg-white p-5">
            <p>
              <strong>Pro tip:</strong> open this calculator on hotel Wi-Fi before you head out.
              That refreshes and caches the latest market rates for the rest of the day.
            </p>
          </div>

          <nav className="mt-8" aria-label="More Tripmetic tools">
            <h2 className="text-2xl font-semibold text-[#0B132B]">More in the Tripmetic travel app</h2>
            <ul className="mt-3 grid gap-2 text-[#0B132B]">
              <li>
                <a className="font-semibold text-[#0288D1]" href="/multi-country-budget">
                  Multi-Country Budgets
                </a>
              </li>
              <li>
                <a className="font-semibold text-[#0288D1]" href="/cryptocurrency-converter">
                  Cryptocurrency Converter
                </a>
              </li>
              <li>
                <a className="font-semibold text-[#0288D1]" href="/bill-splitter-smart-gratuity">
                  Bill Splitter &amp; Gratuity
                </a>
              </li>
              <li>
                <a className="font-semibold text-[#0288D1]" href="/smart-currency-converter">
                  Currency converter guide
                </a>
              </li>
            </ul>
          </nav>
        </section>
      </main>
      <SiteFooter />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "WebApplication",
            name: "Tripmetic Currency Calculator",
            applicationCategory: "FinanceApplication",
            operatingSystem: "Web",
            offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
            url: "https://tripmetic.app/currency-calculator",
          }),
        }}
      />
    </div>
  );
}
