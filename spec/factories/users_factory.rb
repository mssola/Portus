# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    password { "test-password" }
    email { "#{username}@localhost.test.lan" }
    bot { false }

    factory :admin do
      admin { true }
    end
  end
end
