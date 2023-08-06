# frozen_string_literal: true

module Dredd
  class RenderingOrdersController < BaseController
    def index
      @pagy, @rendering_orders = pagy(RenderingOrder.all, items: 20)
    end

    def destroy
      RenderingOrder.find(params[:id]).destroy
      redirect_to dredd_rendering_orders_path, notice: 'Rendering order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end
  end
end
