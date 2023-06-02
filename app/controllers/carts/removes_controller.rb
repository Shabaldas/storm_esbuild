# frozen_string_literal: true

module Carts
  class RemovesController < ApplicationController
    def destroy
      return unless product_found?

      cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
      cart_item.destroy
    end

    private

    def product_found?
      Product.exists?(params[:product_id])
    end
  end
end
