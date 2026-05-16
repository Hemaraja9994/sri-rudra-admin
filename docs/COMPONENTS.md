# Component Library — Sri Rudra Clinic

Canonical patterns used across the site. Every component honors the tokens defined in [`STYLE_GUIDE.md`](./STYLE_GUIDE.md). Markup is React (JSX) + Tailwind, but the styling decisions translate to any framework.

---

## 1. Buttons

Three variants. All use `.btn` as the base utility (`min-h-12`, rounded-full, font-semibold, motion).

### Primary
**Use for:** the single most important action on a page or section (Book, Call, Submit).

```jsx
<button className="btn-primary">
  <Phone className="h-5 w-5" /> Call 9849848516
</button>
```

Visual: maroon fill, ivory text, `--shadow-card`. Lifts 1 px on hover. Only **one** primary button per visible viewport — if you need two, demote one to secondary.

### Secondary
**Use for:** supporting actions (Get directions, WhatsApp).

```jsx
<button className="btn-secondary">
  <MapPin className="h-5 w-5 text-clinic-saffron" /> Get Directions
</button>
```

Visual: porcelain fill, maroon text, hairline saffron border on hover.

### Ghost
**Use for:** tertiary actions inside cards (Dismiss, Cancel).

```jsx
<button className="btn-ghost">Cancel</button>
```

**Don't:** use a ghost button as a primary CTA on the page background — it gets lost. Promote to secondary.

**Loading state:** swap the leading icon for an animated `Loader2` from lucide-react, set `aria-busy="true"`, keep label visible.

**Disabled state:** apply `opacity-60 pointer-events-none`. Disabled controls must still be focusable for screen-reader announcement — use `aria-disabled` instead of the `disabled` attribute when possible.

---

## 2. Forms & inputs

The booking form (`Booking` in `App.jsx`) is the reference implementation. All inputs share the `.field-input` class.

### Input

```jsx
<label>
  <span className="text-xs font-bold uppercase tracking-[0.18em] text-clinic-saffronSoft">
    Patient name *
  </span>
  <input className="field-input mt-2" type="text" value={form.name} onChange={…} />
  {errors.name && <p className="mt-1 text-xs text-clinic-saffronSoft">{errors.name}</p>}
</label>
```

Rules:
- Always render a real `<label>`, not just placeholder text.
- Required fields suffix the label with `*`.
- The error message lives **directly beneath** the input. Always include an icon for non-color users.
- 48 px minimum height (`min-h-12`).

### Select / textarea
Same `.field-input` class works on `<select>` and `<textarea>` (textareas additionally set `min-h-24` and a `py-3` for vertical padding).

### Validation timing
- **On submit:** required-field check.
- **On blur:** format validation (phone regex, email).
- Never validate `onChange` — it punishes typing.

---

## 3. Cards

### `.premium-card`
The default card surface. Rounded `--radius-xl`, hairline border, `--shadow-card`.

Anatomy (top to bottom):
1. Icon chip (`.warm-icon`, 48 px square)
2. Title + Telugu subtitle
3. Body copy (15–16 px)
4. (Optional) bottom action — chevron or text link

Hover lift is opt-in: add `transition hover:-translate-y-1 hover:shadow-soft`. Use only when the entire card is a single link.

### `.surface-card`
Lighter alternative for grouped data (FAQ items, list rows). No lift, just subtle elevation.

### Layout

```jsx
<div className="grid gap-5 md:grid-cols-2 xl:grid-cols-4">
  {items.map(item => <Card key={item.id}>…</Card>)}
</div>
```

For mosaic / asymmetric grids (Gallery), opt into `md:col-span-2 md:row-span-2` on a single hero tile, then let the rest auto-flow.

---

## 4. Navigation

### Top bar (sticky)
- `position: sticky; top: 0; z-50;`
- Translucent ivory (`bg-clinic-porcelain/96`) with `backdrop-blur-xl`.
- Hosts logo + clinic name (English + Telugu) + theme toggle + primary CTA.

### Desktop mega-nav (xl+)
- 8-tile maroon panel that renders below the main bar.
- Each tile: icon chip + bold label + uppercase subtitle.
- Hover lifts the tile and tints the icon chip saffron.

### Mobile sheet
- Triggered by the hamburger; renders a 2-column maroon grid of the same items.
- Tap dismisses the sheet (`onClick={() => setMenuOpen(false)}`).
- The sheet is **not** a `<dialog>` — it's an in-flow expansion. Keep it that way; modal nav steals focus on tiny screens.

### Anchors / smooth scroll
- `html { scroll-behavior: smooth }` is global.
- Provide an in-flow skip link (`a[href="#main"]`) for keyboard users if/when an `<main>` is added.

---

## 5. Section header

The `<Section>` helper composes:
1. **Ornament** — two saffron rules with a 45° lozenge between them.
2. **Kicker** — small uppercase eyebrow (e.g. `Services • సేవలు`).
3. **Title** — `text-5xl sm:text-6xl`, fluid via `clamp`.
4. **Description** — single paragraph, `max-w-2xl`, body size.

```jsx
<Section
  id="booking"
  eyebrow="Booking • అపాయింట్‌మెంట్"
  title="Book a 45-minute consultation."
  description="Fill in your details and pick a slot — your request opens WhatsApp pre-filled."
>
  …children…
</Section>
```

Never override the heading sizes inline — use fluid utilities. Bilingual eyebrows separate English & Telugu with `•`.

---

## 6. Modals / dialogs

We currently use **no modal dialog** on the site. The booking form is intentionally in-flow (modals add friction on mobile). If a dialog becomes necessary:

- Use the shadcn `Dialog` primitive — it handles focus trap, ESC, scroll lock.
- Body must have `--radius-xl`, `--shadow-soft`, and a 24 px close button in the top-right.
- Backdrop: `bg-clinic-ink/40 backdrop-blur-sm`.
- Animate in `--duration-base` with `--ease-out-quad`.
- Always provide an explicit close button — overlay-click-to-dismiss alone is not accessible.

Confirmation dialogs prefer **destructive** = red (`--destructive`) on the cancel side, never the action side.

---

## 7. Accordion (FAQ)

shadcn `Accordion` configured as `type="single" collapsible`.

- Trigger: `font-heading text-2xl font-semibold`, animated chevron.
- Content: 15 px body, `--leading-relaxed`.
- Only one section open at a time; user can close all.

---

## 8. Avatar / quote card

Used in Testimonials. Avatar is the first character of the patient name in `--c-saffron-200` over `--c-maroon-700`. Quote uses regular body weight (not italic Fraunces — testimonials should feel real, not literary).

---

## 9. Image cards (Gallery)

```jsx
<figure className="group relative overflow-hidden rounded-3xl border bg-clinic-cream shadow-card">
  <img src={src} alt={title} className="h-full w-full object-cover transition duration-500 group-hover:scale-[1.03]" />
  <figcaption className="absolute inset-x-4 bottom-4 rounded-2xl border bg-clinic-porcelain/90 p-4 backdrop-blur-xl">
    …title + telugu + caption…
  </figcaption>
</figure>
```

Rules:
- Always include real `alt` text.
- Captions sit on a **frosted glass** panel so they're legible regardless of image brightness.
- Hover scale must not exceed `1.03` — bigger scales feel cheap on slow screens.
- For the bilingual subtitle, use `text-xs` and `text-clinic-clay`.

---

## 10. Ticker / marquee

Linear infinite animation, 54 s loop. Pause on hover via `.ticker-frame:hover .ticker-track`. Edges fade with two pointer-events-none gradient masks.

**Never** add new content to the visible list without also adding it to the screen-reader-only `<ul className="sr-only">` echo — assistive tech can't follow the animated track.

---

## 11. Theme toggle

`ThemeToggle` cycles `light → dark → system`. Persisted in `localStorage["clinic-theme"]`. The button shows:
- `Sun` icon when current effective theme is light.
- `Moon` icon when current effective theme is dark.
- `Sun` icon when on `system` (with title attribute reflecting actual state).

Always pair the toggle with a textual `aria-label` describing the **next** state.

---

## 12. Composition guidelines

- **One CTA per fold.** Booking, Call, WhatsApp — pick one as the dominant primary, demote the rest.
- **No mixed border-radius inside a card.** A card with `--radius-xl` should contain elements at `--radius-lg` or `--radius` — never go bigger than the parent.
- **Aspect ratios** for images: `4/3` for portrait people, `16/9` or `21/9` for room shots, `1/1` for square mosaic tiles. Use Tailwind's `aspect-[4/3]` utilities, not fixed heights.
- **Don't nest premium-card inside premium-card.** Flatten into a section + child grid.
- **Use motion sparingly.** Only the hero, the section reveal, and the ticker animate by default. Stacked animations look chaotic and harm perceived performance.

---

## 13. Adding a new component

1. Sketch the markup in `App.jsx` (or a new file under `src/components/`).
2. Reuse existing tokens for every visual decision.
3. Add the pattern to this document with a 4–6-line snippet and the rules that govern it.
4. Verify keyboard, focus, and dark mode before merging.
5. Run the dev server and visually QA at 360 px, 768 px, 1024 px, 1440 px.
