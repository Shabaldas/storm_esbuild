module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    colors: {
      "dark-blue": "#2A343E",
      "dark-grey": "#2E3841",
      "metalic-grey": "#6E7579",
      "zinc": "#B2BDC5",
      "light-grey": "#E9E9E9",
      "yellow": "#F1C232",
      "white": "#FFFFFF",
    },
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
  },
  plugins: [require("tailwind-accent-color")()],
};
