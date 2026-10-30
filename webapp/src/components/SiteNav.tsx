"use client";

import { useEffect } from "react";
import "./SiteNav.css";

/** Marketing nav — same links and colors as website/menu.html. */
export function SiteNav() {
  useEffect(() => {
    function onClick(event: MouseEvent) {
      const target = event.target;
      if (!(target instanceof Element)) return;
      const toggle = target.closest("[data-nav-toggle]");
      if (toggle) {
        const open = !document.documentElement.classList.contains("nav-open");
        document.documentElement.classList.toggle("nav-open", open);
        toggle.setAttribute("aria-expanded", open ? "true" : "false");
        toggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
        return;
      }
      if (target.closest(".nav-links a")) {
        document.documentElement.classList.remove("nav-open");
        const btn = document.querySelector("[data-nav-toggle]");
        btn?.setAttribute("aria-expanded", "false");
        btn?.setAttribute("aria-label", "Open menu");
      }
    }

    function onResize() {
      if (window.innerWidth > 768) {
        document.documentElement.classList.remove("nav-open");
      }
    }

    document.addEventListener("click", onClick);
    window.addEventListener("resize", onResize);
    return () => {
      document.removeEventListener("click", onClick);
      window.removeEventListener("resize", onResize);
      document.documentElement.classList.remove("nav-open");
    };
  }, []);

  return (
    <nav className="site-nav">
      <div className="nav-inner">
        <a href="/" className="logo">
          Tripmetic
        </a>
        <button
          type="button"
          className="nav-toggle"
          data-nav-toggle
          aria-label="Open menu"
          aria-expanded="false"
          aria-controls="primary-nav"
        >
          <span />
        </button>
        <div className="nav-links" id="primary-nav">
          <a href="/">Home</a>
          <a href="/features">Features</a>
          <a href="/pricing">Pricing</a>
          <a href="/support">Support</a>
          <a href="/contact">Contact Us</a>
          <a href="#download" className="nav-cta">
            Download App
          </a>
        </div>
      </div>
    </nav>
  );
}
