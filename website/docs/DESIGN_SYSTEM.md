# Sri Rudra Clinic Design System

## Visual Audit
The previous site was clean and functional, but it did not yet feel like a premium healthcare brand. The main issues were:

- The teal and white palette felt generic for healthcare and did not draw enough identity from the clinic logo.
- The hero had strong scale but lacked the warm editorial tone requested for a culturally rooted clinic.
- Cards, badges, and sections were visually consistent, but too close to a modern SaaS/startup pattern.
- Telugu labels existed, but some source text was corrupted and the bilingual layer needed quieter hierarchy.
- Several sections had similar visual weight, reducing the sense of curated rhythm.

## Brand Direction
Sri Rudra should feel like a warm, premium clinical practice: calm, serious, reassuring, and rooted in the logo’s maroon and rudraksha character. The design language should combine Indian wellness warmth with restrained Scandinavian spacing.

Core principles:
- Restraint over decoration
- Composition over effects
- Typography over gimmicks
- Whitespace over clutter
- Consistency over novelty
- Emotional calmness over visual noise

## Color Palette
Use a warm single-family palette derived from the logo.

- Ivory background: `#FAF7F1`
- Porcelain surface: `#FFFDF8`
- Warm parchment: `#F2E9DA`
- Soft sand border: `#E2D3BF`
- Deep maroon: `#6E121A`
- Maroon deep: `#4B0B12`
- Rudraksha brown: `#4A2D1B`
- Burnt saffron accent: `#C86B2A`
- Soft saffron wash: `#F7E3CF`
- Ink text: `#221915`
- Umber body text: `#5C4B3F`
- Muted clay: `#8A7868`

Avoid medical blues, bright greens, neon accents, large gradients, and decorative glows.

## Spacing Rhythm
Use an 8px system.

- `2` = 8px
- `4` = 16px
- `6` = 24px
- `8` = 32px
- `10` = 40px
- `12` = 48px
- `16` = 64px
- `20` = 80px
- `24` = 96px
- `28` = 112px

Section rhythm:
- Hero: `py-20` mobile, `lg:py-28`
- Standard sections: `py-20 sm:py-28`
- Dense sections: `py-16 sm:py-20`
- Card gap: `gap-5` or `gap-6`
- Card padding: `p-7` to `p-10`
- Copy width: 560-720px

## Typography Hierarchy
Typography carries the premium feeling.

- Heading font: Newsreader, editorial serif, calm and cinematic.
- Body font: Inter, high-legibility sans.
- Hero: 56px mobile, 96-116px desktop, tight line-height.
- Section headings: 40-56px, tight but readable.
- Card headings: 20-26px.
- Body: 16-20px with generous line-height.
- Eyebrows: small caps, letter-spaced, maroon or clay.
- Telugu: only where useful. Smaller, muted, directly under clinic name and clinical service/facility headings.

## Reusable Component Rules
Navbar:
- Sticky ivory glass with a thin sand border.
- Logo always visible on mobile.
- Navigation is quiet; appointment button is tactile but restrained.

Hero:
- Editorial headline and compact copy.
- One authentic clinic image with warm grading and a quiet caption.
- Trust indicators should read like clinical assurances, not marketing badges.

Cards:
- Rounded `2xl` or `3xl`.
- Porcelain surface, sand border, very soft shadow.
- Icons use maroon or saffron in muted warm containers.
- Hover is subtle: tiny lift, border warmth, no glow.

Booking:
- Should feel like concierge scheduling.
- Dark maroon panel may be used as a single contrast moment.

Footer:
- Deep maroon / rudraksha dark.
- Compact hierarchy, calm links, credible clinic details.

Motion:
- Opacity and small Y movement only.
- 0.55-0.75s duration.
- No bounce, no looped decorative animation except the floating WhatsApp affordance.

Accessibility:
- Maintain contrast against ivory.
- 44px minimum tap targets.
- Avoid overlapping text at 390px width.
- Semantic headings and landmarks.
- Visible focus states in warm maroon/saffron.
