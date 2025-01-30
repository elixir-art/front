/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {      colors: {
      neutral_300: 	"rgb(var(--color-neutral-300))",
      neutral_800: 	"rgb(var(--color-neutral-800))",
      neutral_600: 	"rgb(var(--color-neutral-600))",
      primary_blue: 	"rgb(var(--color-primary-blue))",
    }},
  },
  plugins: [],
}

