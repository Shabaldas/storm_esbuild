# frozen_string_literal: true

class ProductOptionValue < ApplicationRecord
  belongs_to :product_option, inverse_of: :product_option_values
  belongs_to :option_value, inverse_of: :product_option_values

  delegate :product, to: :product_option
  delegate :title, :measurement, :value, to: :option_value

  validates :price, presence: true
end
