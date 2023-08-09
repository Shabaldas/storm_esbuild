# frozen_string_literal: true

module Dredd
  class PrintingOrdersController < BaseController
    before_action :set_printing_order, only: [:edit, :update, :destroy]

    def index
      @pagy, @printing_orders = pagy(PrintingOrder.all, items: 20)
    end

    def edit; end

    def update
      if @printing_order.update(printing_order_params)
        redirect_to dredd_printing_orders_path, notice: 'Printing order was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @printing_order.destroy
      redirect_to dredd_printing_orders_path, notice: 'Printing order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def printing_order_params
      params.require(:printing_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, :total_price, :deadline, :status,
                                             files: [])
    end

    def set_printing_order
      @printing_order = PrintingOrder.find(params[:id])
    end
  end
end
