# frozen_string_literal: true

class ModelingOrdersController < ApplicationController
  include CitiesDetector
  include Sanitizable

  before_action :define_static_variables, only: [:index, :lazy_index, :modeling_in_your_city]

  def index; end

  def lazy_index; end

  def create
    @modeling_order = ModelingOrder.new(sanitize_and_merge_params(modeling_order_params, [:first_name, :last_name, :comment]))

    if @modeling_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to modeling_orders_path }
      end
    else
      render :index
    end
  end

  def modeling_in_your_city
    detect_city(params[:city])
  end

  def define_static_variables
    @modeling_order = ModelingOrder.new
    @modeling_portfolios = Portfolio.modeling.active.with_attached_main_picture
  end

  private

  def modeling_order_params
    params.require(:modeling_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
