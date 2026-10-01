# Website Visual Upgrade Plan

## Goal
Move the site from a basic landing page into a premium medical portal for audiology and speech-language pathology care.

## Key Sections
- Sticky glass navbar with visible logo and appointment CTA.
- Hero with trust badges, large medical headline, clinic imagery, and clear WhatsApp/call actions.
- Clinical Facilities & Services banners for audiology, hearing aids, speech-language pathology, and team approach.
- Card-based service grid with icons and concise descriptions.
- Trust section showing clinic strengths, all-age care, evidence-based therapy, and appointment-based allied support.
- Testimonials section with restrained avatar cards.
- FAQ accordion for appointment, hearing tests, speech therapy, and weekend availability.
- Resource hub linking to CDC milestones, ASHA public resources, and Action For Autism.
- Final CTA section with WhatsApp and call buttons.
- Compact footer with clinic details.

## Design Rules
- White-first layout with soft teal/cyan/slate accents and warm CTA color.
- Use one spacing rhythm based on 8px increments.
- Use consistent card style: `rounded-2xl`, white background, subtle border, soft shadow.
- Keep Telugu translations only for important labels, CTAs, service headers, and schedule details.
- Avoid visual clutter and avoid overusing dark backgrounds.

## Verification
- Run production build.
- Verify desktop and mobile with Playwright.
- Confirm no console errors.
- Confirm the mobile logo remains visible.
- Confirm shadcn components render correctly.
- Deploy to Cloudflare Pages after verification.
