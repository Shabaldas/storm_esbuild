# frozen_string_literal: true

class ScanningOrdersController < ApplicationController
  include Sanitizable

  before_action :define_static_variables, only: [:index, :lazy]

  def index; end

  def lazy; end

  def create
    @scanning_order = ScanningOrder.new(sanitize_and_merge_params(scanning_order_params, [:first_name, :last_name, :comment]))

    if @scanning_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to scanning_orders_path }
      end
    else
      render :index
    end
  end

  def define_static_variables
    @scanning_order = ScanningOrder.new
    @scanning_portfolios = Portfolio.scanning.active.with_attached_main_picture
  end

  private

  def scanning_order_params
    params.require(:scanning_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
