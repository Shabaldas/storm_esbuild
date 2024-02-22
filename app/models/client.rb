# frozen_string_literal: true

class Client < ApplicationRecord
  # associations
  has_many :manual_orders # rubocop:disable Rails/HasManyOrHasOneDependent

  # validations
  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
