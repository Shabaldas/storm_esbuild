# frozen_string_literal: true

class Cart < ApplicationRecord
  has_secure_token

  belongs_to :order, optional: true

  has_many :cart_items, dependent: :destroy

  def total_price
    array = []
    cart_items.each do |cart_item|
      array << if cart_item.cartable.is_a?(PrintModelAttribute)
                 (cart_item.cartable.subtotal_price * cart_item.quantity)
               else
                 (cart_item.cart_item_option_values.sum(&:price) * cart_item.quantity)
               end
    end
    array.sum
  end
end
