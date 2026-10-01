# Sri Rudra Clinic — Style Guide

A single source of truth for visual & interaction language across the site.
All tokens live in [`src/index.css`](../src/index.css) under `@layer base { :root { … } }` and are exposed as CSS custom properties so they work in plain CSS, Tailwind utilities, and `style={}` attributes alike.

---

## 1. Foundational principles

1. **Quiet clinical calm.** Maroon + saffron + ivory. Generous white-space, serif headings, sans-serif body. Never shout.
2. **Bilingual-ready.** Every primary heading can carry a Telugu subtitle. The Telugu treatment is always a smaller, lighter weight under the English.
3. **Accessibility is not optional.** WCAG 2.1 AA contrast minimum, visible focus ring on every interactive element, motion respects `prefers-reduced-motion`.
4. **Token-first.** No hex codes or magic numbers inside components — only `hsl(var(--token))`, `var(--space-…)`, etc. Changes propagate everywhere.
5. **Mobile-first responsive.** Layout adapts at `sm` (640) → `md` (768) → `lg` (1024) → `xl` (1280). Typography uses `clamp()` to flow fluidly between them.

---

## 2. Color system

### 2.1 Brand scale (raw)

| Token              | Light hex  | Use                                   |
|--------------------|------------|---------------------------------------|
| `--c-maroon-900`   | `#4E141C`  | Hero accents, footer base             |
| `--c-maroon-700`   | `#6B1F2A`  | Primary brand, CTAs                   |
| `--c-saffron-600`  | `#D98C2B`  | Accent, focus, links                  |
| `--c-saffron-200`  | `#F6E6D4`  | Soft accent fills, hover states       |
| `--c-rudraksha-700`| `#5A3A22`  | Secondary text emphasis               |
| `--c-ivory-50`     | `#F8F5F1`  | Page background                       |
| `--c-porcelain-50` | `#FBF8F3`  | Card surfaces                         |
| `--c-parchment-100`| `#F2EBE0`  | Muted blocks                          |
| `--c-sand-200`     | `#DCCBB8`  | Hairline borders                      |
| `--c-ink-900`      | `#2A2420`  | Body text                             |
| `--c-umber-600`    | `#4A3F36`  | Secondary body                        |
| `--c-clay-500`     | `#7A6A5C`  | Placeholder / meta                    |

### 2.2 Semantic tokens

Components must consume semantic tokens, never raw scale:

```css
--background        /* page                  */
--foreground        /* default text          */
--surface           /* elevated card         */
--surface-muted     /* muted block           */
--surface-strong    /* maroon panel          */
--primary           /* main CTA              */
--secondary         /* secondary action      */
--accent            /* saffron highlight     */
--muted             /* low-emphasis bg       */
--muted-foreground  /* low-emphasis text     */
--border            /* hairlines             */
--ring              /* focus ring color      */
--destructive       /* error / warning       */
```

### 2.3 Contrast targets (WCAG AA)

| Pair                                       | Ratio | Pass? |
|--------------------------------------------|-------|-------|
| `--foreground` on `--background` (light)   | 14.6:1| AAA   |
| `--primary-foreground` on `--primary`      | 9.1:1 | AAA   |
| `--accent-foreground` on `--accent`        | 5.4:1 | AA    |
| `--muted-foreground` on `--background`     | 5.2:1 | AA    |
| `--foreground` on `--background` (dark)    | 12.3:1| AAA   |

Whenever you introduce a new color combination, verify it at <https://webaim.org/resources/contrastchecker/>.

### 2.4 Dark mode

Triggered by `<html class="dark">` **or** `[data-theme="dark"]`. The `ThemeToggle` component cycles `light → dark → system`. When `system` is active, OS `prefers-color-scheme` decides. The override is persisted in `localStorage["clinic-theme"]`.

```css
/* Dark mode overrides only the semantic layer; brand scale stays put. */
.dark { --background: 220 16% 8%; --foreground: 39 30% 94%; … }
```

Rules for dark surfaces:
- Replace ivory page with deep neutral; never with pure black.
- Soften maroon for primary so it doesn't burn (`24 66% 56%`).
- Drop drop-shadow saturation; raise alpha (`rgba(0,0,0,0.7)`).

---

## 3. Typography

| Token         | Light range                                | Use case                  |
|---------------|--------------------------------------------|---------------------------|
| `--text-xs`   | 11.5–12.5 px                                | Eyebrow labels, captions  |
| `--text-sm`   | 13.5–14.7 px                                | Meta, secondary           |
| `--text-base` | 15–16.6 px                                  | Body                      |
| `--text-lg`   | 17.3–19.5 px                                | Lead paragraphs           |
| `--text-xl`   | 19.5–22.7 px                                | Card titles               |
| `--text-2xl`  | 23.2–28.5 px                                | Subheads                  |
| `--text-3xl`  | 28.5–36.8 px                                | Section titles (small)    |
| `--text-4xl`  | 34.4–48 px                                  | Section titles            |
| `--text-5xl`  | 41.6–63.2 px                                | Section heroes            |
| `--text-6xl`  | 49.6–80 px                                  | Page hero only            |

Use `clamp()`-based fluid utilities (`.text-fluid-3xl` etc.) for hero/section titles. For inline copy keep Tailwind utilities (`text-base`, `text-lg`) — they don't fluid-scale, which is correct for paragraph-level prose.

Line heights:
- Headings: `--leading-tight` (1.1)
- Subheads / large body: `--leading-snug` (1.3)
- Paragraphs: `--leading-normal` (1.55)
- Long-form / FAQ: `--leading-relaxed` (1.72)

Telugu pairing: Telugu runs slightly **shorter** in font weight (`400`) and one step **smaller** than its English partner, with the brand clay color (`text-clinic-clay`).

---

## 4. Spacing & layout

A strict **4-point grid**: every gap is a multiple of `0.25rem`.

| Token        | Value     | Typical use                |
|--------------|-----------|----------------------------|
| `--space-1`  | 4 px      | Tight icon gaps            |
| `--space-2`  | 8 px      | Chip padding, badge gap    |
| `--space-3`  | 12 px     | Form-row gap               |
| `--space-4`  | 16 px     | Card inner gap             |
| `--space-6`  | 24 px     | Section sub-block gap      |
| `--space-8`  | 32 px     | Card padding               |
| `--space-10` | 40 px     | Block separators           |
| `--space-12` | 48 px     | Major section gaps         |
| `--space-16` | 64 px     | Page rhythm                |
| `--space-20` | 80 px     | Section top/bottom         |
| `--space-24` | 96 px     | Section top/bottom (large) |

Container: `.section-shell` is `max-width: 80rem` with fluid inline padding `clamp(1rem, .6rem + 2vw, 2rem)`. Use it for every section — never set custom max-widths inline.

Breakpoints (Tailwind defaults, kept intentionally standard):

| Name | Min width | Typical pivot                                 |
|------|-----------|-----------------------------------------------|
| `sm` | 640 px    | 2-column card grids appear                    |
| `md` | 768 px    | Section heroes go side-by-side                |
| `lg` | 1024 px   | Full desktop nav; 2-col booking               |
| `xl` | 1280 px   | Pinned mega-nav, 4-up card grids              |
| `2xl`| 1536 px   | Hero typography breathes to its max           |

---

## 5. Radius, elevation, motion

**Radius**
- `--radius-xs` (6 px) — chips
- `--radius-sm` (8 px) — inputs
- `--radius`    (16 px) — small cards
- `--radius-lg` (24 px) — large cards
- `--radius-xl` (32 px) — hero cards, image frames
- `--radius-2xl`(40 px) — photo mosaics
- `--radius-full` — pills, buttons, avatars

**Elevation** (layered shadows that bias warm brown, not gray)
- `--shadow-sm` — chip / subtle hover
- `--shadow-card` — default cards
- `--shadow-soft` — featured panels
- `--shadow-glow` — hero CTA, focus emphasis
- `--hairline` — `inset 0 1px 0 rgba(255,255,255,.72)` for glass effect on light cards

**Motion**
- `--duration-fast` (180 ms) — micro-interactions (hover, focus)
- `--duration-base` (260 ms) — default transition
- `--duration-slow` (520 ms) — page-section reveals
- `--duration-ambient` (1200 ms) — background loops, ticker
- `--ease-out-quad` `cubic-bezier(.22,1,.36,1)` — default ease
- `--ease-out-soft` `cubic-bezier(.16,1,.3,1)` — gentle entrances

All motion must be wrapped in a `prefers-reduced-motion: reduce` guard. The global rule in `index.css` already collapses animations to 0.01 ms when the user opts out.

---

## 6. Accessibility standards

- **Tap targets:** minimum `44 × 44 px`. The `min-h-12` (48 px) utility is the default for buttons and inputs.
- **Focus:** visible `--focus-ring` (`0 0 0 4px hsl(var(--ring)/.30)`) on every interactive element. Never set `outline: none` without a replacement.
- **Color is never the sole signal.** Selected slots get a maroon fill **and** a different border. Errors carry an icon + text.
- **Forms:** every input has a visible `<label>`. Required fields end in `*`. Errors live directly under the input with `aria-live="polite"` and an icon.
- **Images:** decorative images carry `aria-hidden="true"` and empty `alt`. Content images describe what's shown (e.g. *"Sound-treated audiometry booth with calibrated audiometer"*).
- **Headings:** strict hierarchy — `<h1>` only in the hero; sections use `<h2>`; subsections `<h3>`. Never skip levels for visual sizing — use fluid type utilities instead.
- **Language:** the `<html lang>` stays `en`, but bilingual snippets are wrapped in `<span lang="te">` so screen readers can switch voice.
- **Motion:** any animation longer than 200 ms must be opt-out friendly.
- **Keyboard:** every menu, accordion, and modal must be operable without a mouse. shadcn primitives already handle this — don't bypass them.

---

## 7. Brand voice

- **Calm, plain English.** "We listen first" beats "We engage in a structured intake protocol."
- **Specifics > superlatives.** Name brands (*Phonak, Signia*), name procedures (*tympanometry, OAE screening*), name districts (*MVP Double Road*). Avoid words like *world-class, cutting-edge, comprehensive 360°*.
- **Telugu is parallel, not decorative.** Translations stand alongside, not below, the brand experience.

---

## 8. Where to extend

When you add a new color, type step, spacing value, or motion curve:
1. Add the **token** under `:root` in `index.css`.
2. If it's a color, **also add a dark counterpart**.
3. Reference it via `var(--…)` — never inline the value.
4. Add a row to the relevant table in this doc.
5. If a new pattern (e.g. tag, badge, modal) emerges, document it in [`COMPONENTS.md`](./COMPONENTS.md).
