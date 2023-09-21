# frozen_string_literal: true

class ModelingOrdersController < ApplicationController
  def index
    @modeling_order = ModelingOrder.new
    @modeling_portfolios = Portfolio.modeling.active.active.with_attached_main_picture
  end

  def create
    @modeling_order = ModelingOrder.new(modeling_order_params)

    if @modeling_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to modeling_orders_path }
      end
    else
      render :index
    end
  end

  private

  def modeling_order_params
    params.require(:modeling_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
