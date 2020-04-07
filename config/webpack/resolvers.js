const path = require('path');

module.exports = {
  resolve: {
    extensions: ['.js', '.vue'],
    mainFields: ['jsnext', 'main', 'browser'],
    alias: {
      '@portus': path.resolve(__dirname, '..', '..', 'app/frontend'),
      '@portus-vendor': path.resolve(__dirname, '..', '..', 'vendor/assets/javascripts'),
      '@bootstrap': 'bootstrap-sass/assets/javascripts/bootstrap',
      vue$: 'vue/dist/vue.esm.js',
    },
  },
};
