const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    screens: {
      sm: '640px',
      md: '768px',
      lg: '1025px',
      xl: '1280px',
      '2xl': '1536px',
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',

      black: '#000',
      white: '#fff',
      "dark-blue": "#2A343E",
      "dark-grey": "#2E3841",
      "metalic-grey": "#6E7579",
      "light-blue": "#3E4C59",
      "red": "#FF0000",
      "zinc": "#B2BDC5",
      "light-grey": "#E9E9E9",
      'disabled': '#CCCCCC',
      'bordercolor': '#CCCCCC',
      'hover-light': '#F3EFFE',
      'labelcolor': '#1a1a1a',

      gray: {
        100: '#717171',
        200: '#D4D6DC',
        300: '#3D3D3D',
        400: '#9C9FAE',
        500: '#808497',
        600: '#505362',
        700: '#2D2F38',
        800: '#16171C',
        900: '#000000'
      },
      red: {
        500: '#FD1525'
      },
      orange: {
        500: '#FF9D00'
      },
      green: {
        500: '#B0B42B',
      },
      yellow: {
        500: '#FFCB00'
      },
      blue: {
        200: '#4860E5',
        500: '#3F50B4'
      },
      petrol: {
        500: '#55609E',
        600: '#3E4674',
        700: '#2C3252',
        800: '#1A1E31'
      },
    },
    columns: {
      auto: 'auto',
      1: '1',
      2: '2',
      3: '3',
      4: '4',
      5: '5',
      6: '6',
      7: '7',
      8: '8',
      9: '9',
      10: '10',
      11: '11',
      12: '12',
      '3xs': '16rem',
      '2xs': '18rem',
      xs: '20rem',
      sm: '24rem',
      md: '28rem',
      lg: '32rem',
      xl: '36rem',
      '2xl': '42rem',
      '3xl': '48rem',
      '4xl': '56rem',
      '5xl': '64rem',
      '6xl': '72rem',
      '7xl': '80rem',
    },
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
    borderWidth: {
      DEFAULT: '2px',
      '0': '0px',
      '1': '1px',
      '2': '2px',
      '4': '4px',
      '10': '10px',
    },
    extend: {
      minWidth: {
        'auto': 'auto',
        'btn-default': '40px',
        '56': '14rem',
      },
      minHeight: {
        'auto': 'auto',
        'btn-default': '40px',
        '8': '2rem',
        '12': '3rem',
        '24': '6rem',
        '32': '8rem',
        '48': '12rem',
        '96': '24rem',
        '144': '36rem',
      },
      colors: {
        'primary': '#f1c232',
        'link': '#3F50B4',
        'link-hover': '#4860E5',
        'disabled': '#B8BAC5',
        'danger': '#FD1525',
        'info': '#3F50B4',
        'card': '#F0F1F3',
        'actionbar': '#000000',
        'bordercolor': '#D4D6DC',
      },
      fontSize: {
        "heading-1": ['3.375rem', '4.08rem'],
        'heading-2': ['1.85rem', '1.85rem'],
        'heading-3': ['1.7rem', '1.7rem'],
        'heading-4': ['1.25rem', '1.25rem'],
        'label': ['0.8rem', '0.8rem'],
        'icon-default': '20px',
        'icon-lg': '40px',
        'icon-xl': '60px',
        'icon-sm': '18px',
        'icon-xs': '16px',
        'xs': ['0.75rem', '0.75rem'],
        'display-1': ['9.375rem', '9.375rem'],
      },
      borderRadius: {
        DEFAULT: '0.3rem',
        'default': '0.3rem'
      },
      fontSize: {
        "heading-1": ['3.375rem', '4.08rem'],
        'heading-2': ['1.125rem', '1.55rem'],
        'heading-3': ['0.875rem', '1.375rem'],
        'heading-4': ['0.75rem', '0.75rem'],
        'display-1': ['2.125rem', '1rem'],
        'label': ['0.75rem', '1rem'],
        'icon-default': '20px',
        'icon-lg': '40px',
        'icon-xl': '60px',
        'icon-sm': '18px',
        'icon-xs': '16px',
        'hint': ['0.75rem', '0.875rem'],
        'title': ['1.125rem', '1.25rem'],
        'forms': ['0.875rem', '0.875rem'],
        'button': ['0.875rem', '1.2rem'],
        'button-sm': ['0.75rem', '1.125rem'],
      },
      spacing: {
        'btn-default': '40px',
        'header' : '60px',
        'icon' : '20px',
        'icon-lg' : '40px',
        'icon-xl' : '60px',
        'icon-sm' : '18px',
        'icon-spacing' : '8px',
        'heading' : '1rem',
        'heading-lg' : '2rem',
        'actionbar' : '70px',
        'aside' : '20rem',
        'sidebar' : '16rem',
        '13': '3.25rem',
        '144': '36rem',
        '192': '48rem',
        '240': '60rem',
      },
      maxWidth: {
        '1/2': '50%',
        '2/3': '66%',
        '8': '2rem',
        '32': '8rem',
        '48': '12rem',
        '96': '24rem',
        '144': '36rem',
      },
      gridTemplateColumns: {
        '3-1': '3fr 1fr',
        'max-auto': 'max-content auto',
        '4-auto': 'auto auto auto auto',
        '14': 'repeat(14, minmax(0, 1fr))',
      },
      gridTemplateRows: {
        'auto-auto': 'auto auto',
      },
      borderRadius: {
        DEFAULT: '0.25rem',
        'default': '0.25rem',
        'lg': '0.5rem',
      },
      boxShadow: {
        DEFAULT: '0 3px 6px 0 rgba(0, 0, 0, 0.2), 0 0px 0px 0 rgba(0, 0, 0, 0.05)',
      },
      screens: {
        '3xl': '1900px',
      },
      backgroundImage: theme => ({
        'pattern-disabled-bright': "url('icons_svg/pattern-striped-bright.png')",
        'pattern-disabled-dark': "url('icons_svg/pattern-striped-dark.png')"
      }),
    }
  },
  variants: {
    extend: {
      margin: ['first', 'last'],
      padding: ['first', 'last'],
      borderRadius: ['first', 'last'],
      borderWidth: ['first', 'last'],
      backgroundColor: ['active'],
      backgroundImage: ['hover', 'focus'],
      textColor: ['group-hover', 'active']
    }
  },
  plugins: [
    require("tailwind-accent-color")(),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms')({ strategy: 'class' }),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/typography')
  ],
};
