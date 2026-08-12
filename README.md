# Sri Rudra · Staff Portal

Cloudflare Pages + Pages Functions + D1. React SPA · JWT sessions · bcrypt · optional OTP.

## 🔑 Default login (ships in seed.sql)

```
Username: prasad     Password: sriRudra@2026     Role: owner
Username: staff      Password: sriRudra@2026     Role: staff
```

**Change these on first sign-in** (Settings → Change password). Both are bcrypt-hashed on the server (cost 10). If you'd rather ship a different default, regenerate the hash with `node tools/hash-password.mjs "MyPassword"` and paste it into `seed.sql`.

## 🚀 Deploy in two commands

Prerequisites: Node ≥ 18, the Cloudflare API token, and the account ID.

```bash
unzip sri-rudra-admin-portal.zip && cd admin-portal
npm install
export CLOUDFLARE_API_TOKEN="cfat_..."         # your token
export CLOUDFLARE_ACCOUNT_ID="08a8370d..."     # your account id
npm run db:apply           # applies schema.sql to the existing D1 database
npm run db:seed            # inserts the clinic + Prasad + staff users
npx wrangler pages secret put JWT_SECRET --project-name=sri-rudra-admin
                            # paste any 32+ char random string when prompted
npm run build
npm run deploy             # → https://sri-rudra-admin.pages.dev
```

That's it. Visit the URL, sign in with `prasad` / `sriRudra@2026`, change the password.

## 🌐 Point at your real domain

The domain `srirudraspeechandhearing.com` is already yours. Two clean options:

1. **Subdomain** (recommended — keeps the marketing site and portal separate):
   - Cloudflare dashboard → Pages → `sri-rudra-admin` → Custom domains → **Set up a custom domain** → enter `admin.srirudraspeechandhearing.com`
   - Cloudflare auto-creates the DNS record.
2. **Sub-path on the same site** (`srirudraspeechandhearing.com/admin`):
   - Requires a Cloudflare Worker route that proxies `/admin/*` to the Pages project.
   - I'd suggest starting with option 1 — it's 30 seconds of clicking versus 15 minutes of Worker rules.

## 📱 OTP for password reset (optional)

Ships in "debug" mode — the OTP comes back in the JSON response of `/api/forgot-password` and is logged in the Worker console. **Perfect for testing without an SMS gateway.** For real texts to Prasad's `+91 70320 54275`:

```bash
# MSG91 (Flow API) is wired in functions/_lib/sms.js
npx wrangler pages secret put MSG91_AUTH_KEY --project-name=sri-rudra-admin
npx wrangler pages secret put MSG91_TEMPLATE_ID --project-name=sri-rudra-admin
# Then edit wrangler.toml: SMS_DEBUG = "false"
```

Prefer Fast2SMS or Twilio? Edit `functions/_lib/sms.js` — it's ~15 lines and the interface won't change.

## 🎨 Visual language (matches your template)

- **Cocoa brown** primary (`#3E2416` / deeper `#1F1108`) — sidebar, buttons, headers
- **Warm gold** accent (`#B8946A` / `#9B7A54`) — italic accents, active states, brand mark
- **Warm ivory** background (`#F8F1E7`) with **cream** cards (`#FBF6EE`)
- **Fraunces** for headlines (matches marketing site) — Plus Jakarta Sans for UI

## 🗂 What's built

| Module | Status |
|---|---|
| Login (JWT + bcrypt) + rate-limit | ✅ working |
| Forgot password → OTP → reset | ✅ working (debug mode until MSG91 keys set) |
| Change password (from Settings) | ✅ working |
| Dashboard — today's payments, schedule, 30-day roll-up | ✅ working |
| Payments — cash / UPI / card / advance / HA token / refund | ✅ working |
| Appointments — book, list, status update | ✅ working |
| Test reports — audiogram + impedance | ✅ working (SVG plot, both ears, air + bone) |
| Attendance | 🟡 schema ready — waiting on model choice (see below) |
| Expenses | 🟡 schema ready — waiting on category list |
| Multi-clinic | ✅ schema + isolation ready — UI adds branches via SQL insert for now |
| Audit trail | ✅ every mutation logged |

## 🔒 Security posture

- HTTPS-only (Cloudflare edge, TLS 1.3)
- Passwords bcrypt-hashed (cost 10) — server-side, never plaintext
- JWT sessions signed HS256, HttpOnly + SameSite=Lax cookie
- Server session table with instant revocation (log-out-all-devices)
- 5-attempt/15-min lockout on login (per-username OR per-IP)
- 5-attempt cap + 10-min expiry on OTPs
- Audit log for every login, payment, report, appointment, password change
- Row-level tenant isolation — every query filtered by `clinic_id`

## 🧩 Local dev

```bash
npx wrangler pages dev -- npm run dev
# Serves the SPA at http://localhost:8788 with Pages Functions + D1 shim
```

Add `--remote` to point Functions at the real D1 database instead of the local shim.

## ✋ Two things I still need from you to polish this

1. **Attendance model** — do staff punch in via their own logins on a shared tablet (the D1 sessions become the audit trail), or does the owner mark daily attendance in bulk? Table is ready; UI plugs in either way.
2. **Expense categories** — give me your working list (rent / salary / consumables / utilities / equipment / other?) and I'll wire the form to match.

Ping with those and I'll ship a v2.
