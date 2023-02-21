# frozen_string_literal: true

class ProductOptionValue < ApplicationRecord
  belongs_to :product_option
  belongs_to :option_value

  validates :price, presence: true
end
