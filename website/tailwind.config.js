/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  darkMode: ['class', '[data-theme="dark"]'],
  theme: {
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
        clinic: {
          maroon: '#6B1F2A',
          maroonDeep: '#4E141C',
          rudraksha: '#5A3A22',
          rudrakshaDark: '#3E2715',
          burntOrange: '#C96A2B',
          saffron: '#D98C2B',
          saffronSoft: '#F6E6D4',
          copper: '#B86B3C',
          gold: '#C9A35B',
          ivory: '#F8F5F1',
          porcelain: '#FBF8F3',
          parchment: '#F2EBE0',
          beige: '#E8DED1',
          sand: '#DCCBB8',
          cream: '#FBF8F3',
          ink: '#2A2420',
          charcoal: '#2A2420',
          umber: '#4A3F36',
          clay: '#7A6A5C',
        },
      },
      borderRadius: {
        '4xl': '2rem',
        '5xl': '2.5rem',
      },
      boxShadow: {
        soft: '0 24px 60px -20px rgba(74, 41, 27, 0.18)',
        card: '0 14px 40px -18px rgba(74, 41, 27, 0.12)',
        glow: '0 0 0 1px rgba(107,31,42,0.06), 0 30px 80px -30px rgba(107,31,42,0.25)',
        hairline: 'inset 0 1px 0 rgba(255,255,255,0.72)',
      },
      fontFamily: {
        sans: ['"Inter Variable"', 'Inter', 'ui-sans-serif', 'system-ui', 'Segoe UI', 'Arial', 'sans-serif'],
        heading: ['"Fraunces Variable"', 'Fraunces', 'Georgia', 'ui-serif', 'serif'],
      },
    },
  },
  plugins: [],
};
