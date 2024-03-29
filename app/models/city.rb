# frozen_string_literal: true

class City < ApplicationRecord
  validates :english_name, :ukrainian_name, presence: true

  scope :active, -> { where(active: true) }
end
