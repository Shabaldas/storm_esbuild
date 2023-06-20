# frozen_string_literal: true

class CartItemOptionValue < ApplicationRecord
  belongs_to :product_option_value

  delegate :price, to: :product_option_value
end
