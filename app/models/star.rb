# frozen_string_literal: true

# == Schema Information
#
# Table name: stars
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  repository_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_stars_on_repository_id  (repository_id)
#  index_stars_on_user_id        (user_id)
#

class Star < ApplicationRecord
  belongs_to :repository
  belongs_to :user

  validates :repository, presence: true
  # TODO
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :user, presence: true, uniqueness: { scope: :repository }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
