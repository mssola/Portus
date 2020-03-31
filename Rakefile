# frozen_string_literal: true

require "git_validation/task"
require "grape-swagger/rake/oapi_tasks"
require "rubocop/rake_task"

# Rails stuff.
require File.expand_path("config/application", __dir__)
Rails.application.load_tasks

# Generate the API docs from Grape.
require "api/root_api"
GrapeSwagger::Rake::OapiTasks.new(Api::RootApi)

##
# Linters: rubocop and git-validation

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = [
    "--extra-details", "--display-style-guide", "--display-cop-names"
  ]
end

GitValidation::Task.new(:"git-validation") do |t|
  t.from  = "bef0fe19d3a5d1e215a4fbadd496ad61699e63f9"
  t.quiet = ENV["CI"].blank?
end
