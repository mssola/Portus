# frozen_string_literal: true

source "https://rubygems.org"

# TODO(mssola): use 6.1.x whenever that is released. We are using the branch
# directly to avoid a bug on zeitwerk that will be released with 6.1.0.
gem "rails", git: "https://github.com/rails/rails.git", branch: "6-0-stable"

gem "active_record_union"
gem "base32"
gem "devise"
gem "font-awesome-rails"
gem "grape", "~> 1.3"
gem "grape-entity"
gem "grape-swagger"
gem "grape-swagger-entity"
gem "gravatar_image_tag"
gem "hashie-forbidden_attributes"
gem "jwt"
gem "kaminari"
gem "net-ldap"
gem "omniauth-github"
gem "omniauth-gitlab"
gem "omniauth-google-oauth2"
gem "omniauth-openid"
gem "omniauth-rails_csrf_protection", "~> 0.1.2"
gem "omniauth_openid_connect"
gem "public_activity", "~> 1.6.3"
gem "pundit"
gem "redcarpet"
gem "ruby-openid", "~> 2.9.2"
gem "sassc-rails"
gem "search_cop"
gem "slim"
gem "webpack-rails"

gem "rack-cors"

# Supported DBs
gem "mysql2", group: :db
gem "pg", group: :db

# Pinning these specific versions because that's what we have on OBS.
gem "ethon"
gem "typhoeus"

# Used to store application tokens.
gem "bcrypt"

# If the deployment is done through Puma, include it in the bundle.
gem "puma"

# Configuration management
gem "cconfig", "~> 1.3.0"

# Pinning some versions
gem "i18n"
gem "ice_nine"
gem "minitest"
gem "multi_json"
gem "rails-dom-testing"
gem "sprockets", "~> 3"
gem "sprockets-rails"
gem "temple"

##
# The following groups will *not* be included on the production installation.

group :assets do
  gem "bootstrap-sass"
  gem "uglifier"
end

group :development do
  gem "annotate"
  gem "git-review", require: false
  gem "guard", require: false
  gem "guard-rspec", require: false
  gem "guard-rubocop", require: false
  gem "pry-rails"
  gem "rack-mini-profiler", require: false
  gem "rails-erd"
  gem "web-console"
end

group :development, :test do
  gem "rspec-core"
  gem "rspec-rails"

  gem "awesome_print"
  gem "binman"
  gem "brakeman", require: false
  gem "byebug"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "grape-swagger-rails"
  gem "hirb"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "wirb"
  gem "wirble"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "docker-api"
  gem "json-schema"
  gem "poltergeist", require: false
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "shoulda"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webdrivers", "~> 4.2"
  gem "webmock", require: false
end
