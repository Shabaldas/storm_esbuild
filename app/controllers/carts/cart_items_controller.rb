# frozen_string_literal: true

module Carts
  class CartItemsController < ApplicationController
    def create
      product = Product.find_by(id: cart_item_params[:cartable_id])
      option_ids = cart_item_params['cart_item_option_values_attributes'].values.map { |h| h['product_option_value_id'].to_i }
      current_items = current_cart.cart_items.where(cartable_id: product.id, cartable_type: product.class.name).find do |key|
        key.cart_item_option_values.pluck(:product_option_value_id) == option_ids
      end

      cart_item = current_items.presence || product.cart_items.build(cart_item_params)
      cart_item.quantity += 1 if cart_item.persisted?
      cart_item.save
    end

    def update_quantity
      cart_item = current_cart.cart_items.find_by(id: params[:id])

      if params[:operation] == '+'
        cart_item.quantity += 1
      else
        cart_item.quantity = [cart_item.quantity - 1, 1].max
      end
      cart_item.save
    end

    private

    def cart_item_params
      params.require(:cart_item)
            .permit(:cartable_id, cart_item_option_values_attributes: [:id, :product_option_value_id])
            .merge(quantity: 1, cart_id: current_cart.id)
    end
  end
end
