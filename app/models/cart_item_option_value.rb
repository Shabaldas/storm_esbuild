# frozen_string_literal: true

class CartItemOptionValue < ApplicationRecord
  belongs_to :product_option_value

  delegate :price, to: :product_option_value

  def selected_option_value
    product_option_value.option_value.value
  end
end
