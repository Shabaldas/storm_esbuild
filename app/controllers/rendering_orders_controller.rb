# frozen_string_literal: true

class RenderingOrdersController < ApplicationController
  def index
    @rendering_order = RenderingOrder.new
    @rendering_portfolios = Portfolio.rendering.active.active.with_attached_main_picture
  end

  def create
    @rendering_order = RenderingOrder.new(rendering_order_params)

    if @rendering_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to rendering_orders_path }
      end
    else
      render :index
    end
  end

  private

  def rendering_order_params
    params.require(:rendering_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
