# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.to_a.sum(&:total)
  end
end
