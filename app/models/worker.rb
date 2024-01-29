# frozen_string_literal: true

class Worker < ApplicationRecord
  belongs_to :user, optional: true
  has_many :manual_orders # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
