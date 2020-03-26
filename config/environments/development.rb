# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  # Set consider_all_requests_local to false to see the errors as in production
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Previous "quiet_assets" gem is built in sprockets since 3.1.0.
  config.assets.quiet = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  config.log_level = :debug

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Set this to true when debugging a mailer.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  # Uncomment the following two lines to test the mailer in the real world.
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = true

  # Control which IP's have access to the console. In Dev mode we can allow all private networks
  config.web_console.whitelisted_ips = %w[127.0.0.1/1 ::1 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16]

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Log into the stdout
  STDOUT.sync      = true
  logger           = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = config.log_formatter
  config.logger = ActiveSupport::TaggedLogging.new(logger)

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Disable the hosts check middleware for production, since we might be using
  # custom FQDN with weird SSL setups.
  config.hosts.clear
end
# rubocop:enable Metrics/BlockLength
