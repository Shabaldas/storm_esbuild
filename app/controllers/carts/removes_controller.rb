# frozen_string_literal: true

module Carts
  class RemovesController < ApplicationController
    def destroy
      cart_item = current_cart.cart_items.find_by(id: params[:cart_item])

      return if cart_item.nil?

      destroy_by_item(cart_item)
    end

    def destroy_all
      return if current_cart.cart_items.empty?

      current_cart.cart_items.each do |cart_item|
        destroy_by_item(cart_item)
      end
    end

    private

    def destroy_by_item(cart_item)
      if cart_item.cartable.is_a?(Product)
        cart_item.destroy!
      else
        print_model = cart_item.cartable.print_model
        if print_model.print_model_attributes.one?
          print_model.destroy!
        else
          cart_item.cartable.destroy!
        end
      end
    end
  end
end
