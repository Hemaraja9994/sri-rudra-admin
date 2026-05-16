# Sri Rudra Speech & Hearing Clinic — Brand System

A warm, premium, Indian luxury wellness identity. Calm, spiritual-modern, trustworthy.
Inspired by rudraksha tones, deep maroon, burnt saffron, warm copper, sandstone neutrals,
soft ivory backgrounds, and elegant dark slate-brown text.

This is the single source of truth. Do **not** introduce blue, teal, cyan, neon, or
oversaturated gradients into this product.

---

## 1. Color System

### 1.1 Primary (use with restraint, for emphasis)

| Token            | Hex       | Use                                                          |
| ---------------- | --------- | ------------------------------------------------------------ |
| `maroon`         | `#6B1F2A` | Primary brand color. Buttons, footer, key headings, focus.   |
| `maroonDeep`     | `#4E141C` | Hover state, footer base, deep emphasis.                     |
| `rudraksha`      | `#5A3A22` | Secondary brand brown. Body emphasis, eyebrow text, borders. |
| `rudrakshaDark`  | `#3E2715` | Dark brown for footers, headings on light.                   |

### 1.2 Accent (highlights only)

| Token         | Hex       | Use                                                |
| ------------- | --------- | -------------------------------------------------- |
| `burntOrange` | `#C96A2B` | Hover accents, secondary CTA, link underline.      |
| `saffron`     | `#D98C2B` | Premium highlight, badge accents, gold-like.       |
| `copper`      | `#B86B3C` | Warm metallic accent for icons, dividers.          |
| `gold`        | `#C9A35B` | Footer highlight, elegant rules, premium emphasis. |

### 1.3 Neutrals (the page lives here)

| Token       | Hex       | Use                                              |
| ----------- | --------- | ------------------------------------------------ |
| `ivory`     | `#F8F5F1` | Default background. Warm replacement for white.  |
| `parchment` | `#F2EBE0` | Section alt background.                          |
| `beige`     | `#E8DED1` | Muted blocks, card alt background.               |
| `sand`      | `#DCCBB8` | Borders, dividers, subtle surfaces.              |
| `cream`     | `#FBF8F3` | Lightest card surface.                           |

### 1.4 Text

| Token         | Hex       | Use                                |
| ------------- | --------- | ---------------------------------- |
| `charcoal`    | `#2A2420` | Primary text. Warm near-black.     |
| `umber`       | `#4A3F36` | Secondary text. Warm body gray.    |
| `clay`        | `#7A6A5C` | Tertiary / captions / muted text.  |

### 1.5 Forbidden

- Bright blue, medical cyan, teal, mint
- Neon / electric tones
- Oversaturated gradients
- Pure `#FFFFFF` backgrounds (use ivory instead)

---

## 2. Typography

- **Headings**: `Fraunces` (editorial serif with optical sizing) — bold, slightly expressive.
- **Body / UI**: `Inter` / `Plus Jakarta Sans` — modern sans, highly readable.
- **Telugu / Devanagari support**: system fallback.

### 2.1 Scale

| Token  | Size      | Use                                |
| ------ | --------- | ---------------------------------- |
| `h1`   | 60–96px   | Hero headline. Tight letter-spacing. |
| `h2`   | 36–56px   | Section title.                     |
| `h3`   | 22–28px   | Card title.                        |
| `lead` | 18–20px   | Hero / section description.        |
| `body` | 16px      | Default copy. Line height 1.7.     |
| `small`| 13–14px   | Captions, eyebrows.                |

### 2.2 Headline rules

- Use serif (`font-heading` / Fraunces) for h1–h3.
- Generous leading (1.05–1.15 for hero, 1.2 for sections).
- Slight negative tracking on display sizes.
- Body uses sans, line-height 1.7, color `umber`.

### 2.3 Eyebrow

- Uppercase, tracking `0.24em`, color `maroon`, weight 600, 12–13px.

---

## 3. Spacing

8px base. Sections breathe.

- Section padding-y: `96px` desktop, `64px` mobile.
- Card padding: `28–40px`.
- Grid gap: `24–32px`.
- Max content width: `1200px` (`section-shell`).
- Whitespace is the luxury — do not crowd.

---

## 4. Elevation & surfaces

- Default page: `ivory`.
- Alt section: `parchment` (slight warmer tone).
- Cards: `cream` with `1px` border in `sand`.
- Shadows are warm, soft, layered — never gray-blue.
  - `shadow-soft`: `0 24px 60px -20px rgba(74, 41, 27, 0.18)`
  - `shadow-card`: `0 14px 40px -18px rgba(74, 41, 27, 0.12)`
  - `shadow-glow`: `0 0 0 1px rgba(107,31,42,0.06), 0 30px 80px -30px rgba(107,31,42,0.25)`

---

## 5. Components

### Buttons

- **Primary**: bg `maroon`, text ivory, hover bg `maroonDeep`, optional saffron underline on hover. Rounded `1rem` (16px). Soft warm shadow.
- **Secondary**: bg `cream`, border `sand`, text `charcoal`, hover border `copper`.
- **Ghost on dark**: text `ivory`, border `gold/30`, hover bg `ivory/10`.

### Cards

- Bg `cream`, border `sand`, radius `1.25rem`.
- Hover: lift `-4px`, border `copper/40`, deepen shadow.
- Icon chip: rounded square, bg `maroon/8`, icon color `maroon`. Saffron variant for accent.

### Navbar

- Sticky, warm glass: `bg-ivory/80 backdrop-blur-xl`, border-b `sand`.
- Logo lock-up with serif clinic name + small umber Telugu line.
- CTA: maroon pill.

### Footer

- Deep `rudrakshaDark` background, ivory text.
- Saffron/gold thin top rule.
- Nav chips with `ivory/10` background.

### Icons

- `lucide` outline icons, stroke 1.6.
- Color: `maroon` for primary, `copper`/`saffron` for accent rows.

---

## 6. Motion

- Cinematic, slow, soft.
- Duration: `0.5–0.8s`, ease `[0.22, 1, 0.36, 1]` (easeOutExpo-ish).
- Distances: 16–24px max for fade-up.
- No bouncing, no spring overshoot, no parallax noise.

---

## 7. Texture & depth

- Subtle film grain on hero (`bg-noise` utility, 4–6% opacity).
- Faint radial wash from top: `radial-gradient(at 50% -10%, rgba(217,140,43,0.10), transparent 60%)`.
- Hairline gold divider (`1px`, `gold/40`) below section eyebrows when appropriate.

---

## 8. Voice & feel

- Emotionally warm, medically trustworthy, culturally rooted.
- Reassuring sentence structure. Avoid clinical-cold language.
- Bilingual touches (Telugu under English) where it's meaningful — never as decoration only.

---

## 9. Do / Don't

| Do                                          | Don't                                         |
| ------------------------------------------- | --------------------------------------------- |
| Lead with ivory backgrounds                 | Use pure white or cold gray                   |
| Use maroon sparingly for emphasis           | Use maroon as section background blocks       |
| Use saffron/copper as elegant highlights    | Use saffron as primary fill                   |
| Use serif for display, sans for UI          | Mix four type families                        |
| Use warm shadows                            | Use blue-gray shadows                         |
| Use generous whitespace                     | Crowd cards into tight grids                  |
