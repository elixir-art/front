// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin");
const fs = require("fs");
const path = require("path");

module.exports = {
  darkMode: "class",
  content: [
    "./js/**/*.js",
    "../lib/my_calendar_web.ex",
    "../lib/my_calendar_web/**/*.*ex",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Poppins", "Arial", "sans-serif"], 
        heading: ["Open Sans", "sans-serif"], 
      },
      fontSize: {
        '100': '18px',
        'xl': '32px',
        '2xl': '42px', 
      },
      colors: {
        card_bg: {
          pink: "#FDEBF9",
          blue: "#E8F0FB",
          peach: "#FFEFE7",
          gray: "#B2B2B2",
          gray2: "#686868",
          gray3: "#F1F1F1",
          violet1: "#1B204A",
          violet2: "#161E54"
        },
        active: "#FF5151",
        grayInput: '#B3B3B3',
        accent_text: "#D97706",
        accent_blue: "#3786F1",
        accent_rose: "#FF5151",
        accent_pink: "#EE61CF",
        mainColor: '#FF5151',
        coldBlack: "black",
        customGray: "gray",
        formPrimary: {
          200: "#4A3AFF",
        },
        formSecondary: {
          200: "#EFF0F6"
        },
        red: "#FB3F4A",
        green: "#589C5F"
      },
      borderRadius: {
        input: "46px",
        button: "56px",
        form: "34px",
        target: "16px",
        progress: "40px"
      },
      borderColor: {
        active: "#4A3AFF"
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) =>
      addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-click-loading", [
        ".phx-click-loading&",
        ".phx-click-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-submit-loading", [
        ".phx-submit-loading&",
        ".phx-submit-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-change-loading", [
        ".phx-change-loading&",
        ".phx-change-loading &",
      ])
    ),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized");
      let values = {};
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"],
      ];
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach((file) => {
          let name = path.basename(file, ".svg") + suffix;
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) };
        });
      });
      matchComponents(
        {
          hero: ({ name, fullPath }) => {
            let content = fs
              .readFileSync(fullPath)
              .toString()
              .replace(/\r?\n|\r/g, "");
            let size = theme("spacing.6");
            if (name.endsWith("-mini")) {
              size = theme("spacing.5");
            } else if (name.endsWith("-micro")) {
              size = theme("spacing.4");
            }
            return {
              [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
              "-webkit-mask": `var(--hero-${name})`,
              mask: `var(--hero-${name})`,
              "mask-repeat": "no-repeat",
              "background-color": "currentColor",
              "vertical-align": "middle",
              display: "inline-block",
              width: size,
              height: size,
            };
          },
        },
        { values }
      );
    }),
  ],
};
