"use client";

import { useEffect, useState } from "react";
import "./SiteFooter.css";

const IOS_URL = "https://apps.apple.com/us/app/tripmetic/id6765632920";
const ANDROID_URL =
  "https://play.google.com/store/apps/details?id=com.tripmetic.app";

/** Marketing footer — matches website/footer.html used on the home page. */
export function SiteFooter() {
  const [downloadOpen, setDownloadOpen] = useState(false);

  useEffect(() => {
    function onClick(event: MouseEvent) {
      const target = event.target;
      if (!(target instanceof Element)) return;
      const link = target.closest('a[href="#download"]');
      if (!link) return;
      event.preventDefault();
      setDownloadOpen(true);
    }
    document.addEventListener("click", onClick);
    return () => document.removeEventListener("click", onClick);
  }, []);

  return (
    <footer className="site-footer">
      <div className="footer-container">
        <div className="footer-brand">
          <a href="/" className="footer-logo">
            Tripmetic
          </a>
          <p>
            The professional global toolkit for the modern traveler. Manage
            multi-currency budgets, synchronize timezones, and travel with
            precision-engineered accuracy.
          </p>

          <div className="app-badges">
            <a href={IOS_URL} target="_blank" rel="noopener noreferrer">
              Download iOS
            </a>
            <a href={ANDROID_URL} target="_blank" rel="noopener noreferrer">
              Download Android
            </a>
          </div>

          <div className="social-links">
            <a
              href="https://www.tiktok.com/@tripmetic"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="TikTok"
            >
              <svg viewBox="0 0 448 512">
                <path d="M448 209.91a210.06 210.06 0 0 1-122.77-39.25V349.38A162.55 162.55 0 1 1 185 188.31v89.89a74.62 74.62 0 1 0 52.23 71.18V0l88 0a121.18 121.18 0 0 0 1.86 22.17h0A122.18 122.18 0 0 0 381 102.39a121.43 121.43 0 0 0 67 20.14Z" />
              </svg>
            </a>
            <a
              href="https://x.com/tripmetic"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="X (Twitter)"
            >
              <svg viewBox="0 0 512 512">
                <path d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z" />
              </svg>
            </a>
            <a
              href="https://www.instagram.com/tripmetic.app"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="Instagram"
            >
              <svg viewBox="0 0 448 512">
                <path d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z" />
              </svg>
            </a>
            <a
              href="https://facebook.com/tripmetic"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="Facebook"
            >
              <svg viewBox="0 0 320 512">
                <path d="M279.14 288l14.22-92.66h-88.91v-60.13c0-25.35 12.42-50.06 52.24-50.06h40.42V6.26S260.43 0 225.36 0c-73.22 0-121.08 44.38-121.08 124.72v70.62H22.89V288h81.39v224h100.17V288z" />
              </svg>
            </a>
          </div>
        </div>

        <div className="footer-col">
          <h4>Product</h4>
          <ul>
            <li>
              <a href="/">Home</a>
            </li>
            <li>
              <a href="/features">All Features</a>
            </li>
            <li>
              <a href="/pricing">Pricing</a>
            </li>
            <li>
              <a href="/demo">App Gallery</a>
            </li>
            <li>
              <a href="/introductory-offer">Introductory Offer</a>
            </li>
            <li>
              <a href="/redeem">Redeem</a>
            </li>
            <li>
              <a href="/es">Español</a>
            </li>
          </ul>
        </div>

        <div className="footer-col">
          <h4>Company</h4>
          <ul>
            <li>
              <a href="/about">About Us</a>
            </li>
            <li>
              <a href="/support">Support Center</a>
            </li>
            <li>
              <a href="/contact">Contact Us</a>
            </li>
          </ul>
        </div>

        <div className="footer-col">
          <h4>Tool Guides</h4>
          <ul>
            <li>
              <a href="/multi-country-budget">Multi-Country Budget</a>
            </li>
            <li>
              <a href="/offline-map-guide">Offline Map</a>
            </li>
            <li>
              <a href="/global-meeting-scheduler">Meeting Scheduler</a>
            </li>
            <li>
              <a href="/packing-list">Zen Packing List</a>
            </li>
            <li>
              <a href="/currency-calculator">Currency Calculator</a>
            </li>
            <li>
              <a href="/smart-currency-converter">Currency Converter Guide</a>
            </li>
            <li>
              <a href="/cryptocurrency-converter">Crypto Converter</a>
            </li>
            <li>
              <a href="/bill-splitter-smart-gratuity">Bill Splitter &amp; Gratuity</a>
            </li>
            <li>
              <a href="/clock-widget">Clock Widget</a>
            </li>
            <li>
              <a href="/group-trip-planner">Group Trip Planner</a>
            </li>
            <li>
              <a href="/international-size-converter">Size Converter</a>
            </li>
            <li>
              <a href="/unit-converter">Unit Converter</a>
            </li>
            <li>
              <a href="/brainstorming-mind-map">Mind Map</a>
            </li>
            <li>
              <a href="/bucket-list-app">Bucket List</a>
            </li>
          </ul>
        </div>

        <div className="footer-col">
          <h4>Legal</h4>
          <ul>
            <li>
              <a href="/privacy">Privacy Policy</a>
            </li>
            <li>
              <a href="/terms">Terms of Service</a>
            </li>
            <li>
              <a href="/refund">Refund Policy</a>
            </li>
            <li>
              <a href="/delete-account">Data Deletion</a>
            </li>
            <li>
              <a href="/disclaimer">Disclaimers</a>
            </li>
            <li>
              <a href="/pci-compliance">PCI Compliance</a>
            </li>
          </ul>
        </div>
      </div>

      <div
        id="downloadModal"
        className={`modal-overlay${downloadOpen ? " is-open" : ""}`}
        onClick={(e) => {
          if (e.target === e.currentTarget) setDownloadOpen(false);
        }}
      >
        <div className="modal-content">
          <button
            type="button"
            className="close-modal"
            aria-label="Close"
            onClick={() => setDownloadOpen(false)}
          >
            &times;
          </button>
          <h2>Get Tripmetic</h2>
          <p>Download the ultimate global travel toolkit for your device.</p>
          <div className="store-badges">
            <a href={IOS_URL} target="_blank" rel="noopener noreferrer">
              <img
                src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1276560000&h=7e7b68fad19738b5649a1bfb78ff46e9"
                alt="Download on the App Store"
                className="store-badge apple-badge"
              />
            </a>
            <a href={ANDROID_URL} target="_blank" rel="noopener noreferrer">
              <img
                src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png"
                alt="Get it on Google Play"
                className="store-badge google-badge"
              />
            </a>
          </div>
        </div>
      </div>

      <div className="footer-bottom">
        <p>
          &copy; 2026 Tripmetic. All rights reserved.{" "}
          <span className="footer-separator">&bull;</span>
          <a href="https://tripmetic.app/" style={{ color: "white", textDecoration: "none" }}>
            Tripmetic
          </a>{" "}
          is a DBA of{" "}
          <a
            href="https://dtlaprofessionalservices.com/"
            style={{ color: "white", textDecoration: "none" }}
          >
            DTLA Professional Services, LLC.
          </a>
          <span className="footer-separator">&bull;</span>
          <span className="made-in-ca-container">
            Made in California{" "}
            <img
              src="https://upload.wikimedia.org/wikipedia/commons/0/01/Flag_of_California.svg"
              alt="California Flag"
              className="ca-flag"
            />{" "}
            with Love{" "}
            <svg className="heart-icon" viewBox="0 0 24 24">
              <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
            </svg>
          </span>
        </p>
      </div>
    </footer>
  );
}
