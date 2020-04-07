process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');

environment.config.merge({
  externals: [require('webpack-node-externals')()],
  devtool: 'eval-source-map',
});

const cfg = environment.toWebpackConfig();

// When in CI, print the actual configuration to be extra sure about things.
if (process.env.CI === 'true') {
  console.log('Webpack configuration:');
  console.log(JSON.stringify(cfg, null, '  '));
}

module.exports = cfg;
