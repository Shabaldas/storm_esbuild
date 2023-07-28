# frozen_string_literal: true

class RenderingOrdersController < ApplicationController
  def rendering
    @rendering_order = RenderingOrder.new
  end

  def create
    @rendering_order = RenderingOrder.new(rendering_order_params)

    if @rendering_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :new
    end
  end

  private

  def rendering_order_params
    params.require(:rendering_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
