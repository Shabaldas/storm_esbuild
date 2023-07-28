# frozen_string_literal: true

class PrintingOrdersController < ApplicationController
  def printing
    @printing_order = PrintingOrder.new
  end

  def create
    @printing_order = PrintingOrder.new(printing_order_params)

    if @printing_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      render :new
    end
  end

  private

  def printing_order_params
    params.require(:printing_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
