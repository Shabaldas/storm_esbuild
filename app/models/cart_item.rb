# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  after_update_commit do
    broadcast_replace_to cart,
                         target: "quantity_cart_item_#{id}",
                         partial: 'cart/item_quantity',
                         locals: { current_cart: cart }
    broadcast_replace_to cart,
                         target: "total_price_cart_item_#{id}",
                         partial: 'cart/cart_item_total',
                         locals: { current_cart: cart }
    broadcast_replace_to cart,
                         target: 'total_price',
                         partial: 'cart/total_price',
                         locals: { current_cart: cart }
  end

  after_destroy_commit do
    broadcast_remove_to cart
    broadcast_replace_to cart,
                         target: 'footer_action',
                         partial: 'cart/cart_footer_action',
                         locals: { current_cart: cart }
    broadcast_replace_to cart,
                         target: 'cart_body',
                         partial: 'cart/empty_cart_body',
                         locals: { current_cart: cart }
    broadcast_replace_to cart,
                         target: 'total_price',
                         partial: 'cart/total_price',
                         locals: { current_cart: cart }
  end

  def total
    product.price * quantity
  end
end
