module.exports = {
  mode: 'jit',
  purge: [
    './*.html'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        slate: '#A4A5A6',
        mustard: '#8C7503',
        'dark-green': '#403501',
        yellow: '#F2D857',
        tan: '#D9A273',
      }
    },
  },
  plugins: []
}