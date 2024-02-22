# frozen_string_literal: true

class Client < ApplicationRecord
  # associations
  has_many :manual_orders # rubocop:disable Rails/HasManyOrHasOneDependent

  # validations
  validates :first_name, presence: true
end
