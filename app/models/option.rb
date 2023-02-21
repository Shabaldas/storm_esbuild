# frozen_string_literal: true

class Option < ApplicationRecord
  has_many :option_values, dependent: :destroy
  has_many :product_options, dependent: :destroy

  accepts_nested_attributes_for :option_values, allow_destroy: true

  enum measurement: { mm: 0, color: 1 }

  validates :title, presence: true
end
