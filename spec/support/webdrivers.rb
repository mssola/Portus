# frozen_string_literal: true

require 'webdrivers/chromedriver'

# Before running the test suite, make sure that the Chrome driver has been
# downloaded into the `TMP_WEBDRIVERS_PATH` directory. This is cached for one
# day.

TMP_WEBDRIVERS_PATH = Rails.root.join('tmp/webdrivers')

RSpec.configure do |config|
  config.before(:suite) do
    Webdrivers.install_dir = TMP_WEBDRIVERS_PATH
    Webdrivers.cache_time = 86_400

    # We need to perform a real HTTP request, so we need to make sure that VCR
    # doesn't stand in the way.
    WebMock.allow_net_connect!
    VCR.turned_off { Webdrivers::Chromedriver.update }
    WebMock.disable_net_connect!
  end
end
