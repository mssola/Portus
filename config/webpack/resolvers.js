const path = require('path');

module.exports = {
  resolve: {
    extensions: ['.js', '.vue'],
    mainFields: ['jsnext', 'main', 'browser'],
    alias: {
      '@portus': path.resolve(__dirname, '..', '..', 'app/frontend'),
      '@portus-vendor': path.resolve(__dirname, '..', '..', 'vendor/assets'),
      // NOTE (bootstrap): this can all be redone whenever we migrate to
      // Bootstrap 4.
      '@bootstrap-sass': 'bootstrap-sass/assets',
      '@bootstrapjs': 'bootstrap-sass/assets/javascripts/bootstrap',
      '@bootstrapcss': 'bootstrap-sass/assets/stylesheets/bootstrap',
      vue$: 'vue/dist/vue.esm.js',
    },
  },
};
