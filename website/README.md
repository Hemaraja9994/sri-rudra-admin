# Sri Rudra Clinic Website

Public website for Sri Rudra Speech & Hearing Clinic (Vite + React).

- **Live at:** https://srirudraspeechandhearing.com (and www)
- **Hosting:** Cloudflare Pages project `sri-rudra-speech-hearing-clinic`, connected
  to this repo (root directory `website/`, production branch `main`). Every push to
  `main` publishes the site automatically. Old versions can be restored from the
  project's Deployments tab (Rollback).
- **No patient data:** this site has no database or secrets (see `wrangler.toml`).
- **Staff portal:** https://admin.srirudraspeechandhearing.com (separate site and
  database). The "Admin Login" button (header, phone menu, footer) opens it, and old
  staff links on the main domain (`/login`, `/dashboard`, …) are forwarded there by
  `public/_redirects`.

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

Cloudflare build settings: root directory `website`, build command `npm run build`,
output `dist`. Node 22 comes from `.nvmrc`; project settings come from
`website/wrangler.toml` (kept separate from the staff portal's config).
