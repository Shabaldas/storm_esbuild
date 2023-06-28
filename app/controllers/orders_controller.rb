# frozen_string_literal: true

class OrdersController < ApplicationController
  layout 'checkout'

  def checkout
    @order = current_cart.order.presence || create_orders
  end

  private

  def create_orders
    order = Order.new
    order.save
    current_cart.update(order_id: order.id)
    order
  end
end
