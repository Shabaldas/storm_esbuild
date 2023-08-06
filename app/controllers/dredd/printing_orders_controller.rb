# frozen_string_literal: true

module Dredd
  class PrintingOrdersController < BaseController
    def index
      @pagy, @printing_orders = pagy(PrintingOrder.all, items: 20)
    end

    def destroy
      PrintingOrder.find(params[:id]).destroy
      redirect_to dredd_printing_orders_path, notice: 'Printing order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end
  end
end
