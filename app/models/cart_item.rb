# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :cartable, polymorphic: true

  has_many :cart_item_option_values, dependent: :destroy

  accepts_nested_attributes_for :cart_item_option_values

  # TODO: after create commit
  after_create_commit do
    broadcast_replace_to cart,
                         target: 'cart_body',
                         partial: 'cart/empty_cart_body',
                         locals: { current_cart: cart }

    broadcast_append_to cart,
                        target: 'cart_item',
                        partial: 'cart/item_line',
                        locals: { cart_item: self }

    broadcast_replace_to cart,
                         target: 'footer_action',
                         partial: 'cart/cart_footer_action',
                         locals: { current_cart: cart }

    broadcast_replace_to cart,
                         target: 'total_price',
                         partial: 'cart/total_price',
                         locals: { current_cart: cart }
  end

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
    cartable.price * quantity
  end
end
