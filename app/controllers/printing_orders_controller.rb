# frozen_string_literal: true

class PrintingOrdersController < ApplicationController
  def index
    @printing_order = PrintingOrder.new
    @printing_portfolios = Portfolio.printing.active.with_attached_main_picture
  end

  def create
    @printing_order = PrintingOrder.new(printing_order_params)

    if @printing_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to printing_orders_path }
      end
    else
      render :index
    end
  end

  private

  def printing_order_params
    params.require(:printing_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
