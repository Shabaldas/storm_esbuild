# frozen_string_literal: true

class RenderingOrdersController < ApplicationController
  include CitiesDetector
  include Sanitizable

  before_action :define_static_variables, only: [:index, :lazy, :rendering_in_your_city]

  def index; end

  def lazy; end

  def create
    @rendering_order = RenderingOrder.new(sanitize_and_merge_params(rendering_order_params, [:first_name, :last_name, :comment]))

    if @rendering_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to rendering_orders_path }
      end
    else
      render :index
    end
  end

  def rendering_in_your_city
    detect_city(params[:city])
  end

  def define_static_variables
    @rendering_order = RenderingOrder.new
    @rendering_portfolios = Portfolio.rendering.active.with_attached_main_picture
  end

  private

  def rendering_order_params
    params.require(:rendering_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
