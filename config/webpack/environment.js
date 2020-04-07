const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const webpack = require('webpack');
const resolvers = require('./resolvers');
const style = require('./loaders/style');
const vue = require('./loaders/vue');

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
environment.loaders.prepend('css', style);
environment.config.merge(resolvers);

environment.plugins.append(
  'ProvidePlugin',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    'window.$': 'jquery',
  }),
);

environment.plugins.append(
  'IgnorePlugin',
  new webpack.IgnorePlugin(/^\.\/jquery$/, /jquery-ujs$/),
);

module.exports = environment;
