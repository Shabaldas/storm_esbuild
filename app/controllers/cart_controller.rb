# frozen_string_literal: true

class CartController < ApplicationController
  def add_product
    @product = Product.find_by(id: params[:product_id])

    quantity = params[:quantity].to_i
    cart_items = current_cart.cart_items.find_by(product_id: @product.id)
    if cart_items && quantity.positive?
      cart_items.update(quantity:)
    elsif quantity <= 0
      cart_items.destroy
    else
      current_cart.cart_items.create(product: @product, quantity:)
    end

    redirect_to product_path(@product)
  end
end
