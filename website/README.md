# Sri Rudra Clinic Website

Public website for Sri Rudra Speech & Hearing Clinic (Vite + React).

- **Live at:** https://srirudraspeechandhearing.com (and www)
- **Hosting:** Cloudflare Pages project `sri-rudra-website`, connected to this repo
  (root directory `website/`). Every push to `main` that changes files in
  `website/` publishes the site automatically. This site has no database access.
- **Staff portal:** https://admin.srirudraspeechandhearing.com (separate site).
  Old staff links on the main domain (`/login`, `/dashboard`, …) are forwarded
  there by `public/_redirects`.

## Development

```bash
npm install
npm run dev
```

## Production Build

```bash
npm run build
```

The deployable static output is generated in `dist/`.

Cloudflare build settings: root directory `website`, build command
`npm ci --ignore-scripts && npm run build`, output `dist`, with environment
variables `NODE_VERSION=22` and `SKIP_DEPENDENCY_INSTALL=1` (skips the
asset-tooling downloads for Playwright and ffmpeg, which the build doesn't need).
