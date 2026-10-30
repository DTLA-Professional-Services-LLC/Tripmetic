import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Static export so we can merge into Firebase Hosting (website/) alongside marketing HTML.
  output: "export",
  images: { unoptimized: true },
  trailingSlash: true,
};

export default nextConfig;
