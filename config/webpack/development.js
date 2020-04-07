process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
const environment = require('./environment');

if (process.env.BUNDLE_ANALYZER === 'true') {
  environment.plugins.append(
    'BundleAnalyzerPlugin',
    new BundleAnalyzerPlugin(),
  );
}

module.exports = environment.toWebpackConfig();
