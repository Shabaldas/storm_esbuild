# frozen_string_literal: true

class Cart < ApplicationRecord
  has_secure_token
  has_many :cart_items, dependent: :destroy

  def total_price
    array = []
    cart_items.each do |cart_item|
      array << (cart_item.cart_item_option_values.sum(&:price) * cart_item.quantity)
    end
    array.sum
  end
end
