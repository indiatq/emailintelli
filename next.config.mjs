/** @type {import('next').NextConfig} */
const nextConfig = {

  {
    "functions": {
      "pages/api/**/*.ts": {
        "maxDuration": 60
      }
    }
  },

  images: {
    remotePatterns: [
      {
        hostname: "lh3.googleusercontent.com",
      },
    ],
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  reactStrictMode: false,
};

export default nextConfig;
