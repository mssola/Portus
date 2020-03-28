# frozen_string_literal: true

##
# Checks the ruby requirements.

require "ruby_checker"
::RubyChecker::RubyChecker.new(::RubyChecker::MRI).check!
