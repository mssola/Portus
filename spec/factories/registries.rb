# frozen_string_literal: true

# == Schema Information
#
# Table name: registries
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  hostname          :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  use_ssl           :boolean
#  external_hostname :string(255)
#
# Indexes
#
#  index_registries_on_hostname  (hostname) UNIQUE
#  index_registries_on_name      (name) UNIQUE
#

FactoryBot.define do
  factory :registry do
    before(:create) { create(:admin) }

    sequence :hostname do |n|
      "registry.hostname:#{n}"
    end

    name { hostname }
    use_ssl { false }
  end
end
