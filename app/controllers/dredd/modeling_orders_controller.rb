# frozen_string_literal: true

module Dredd
  class ModelingOrdersController < BaseController
    def index
      @pagy, @modeling_orders = pagy(ModelingOrder.all, items: 20)
    end

    def destroy
      ModelingOrder.find(params[:id]).destroy
      redirect_to dredd_modeling_orders_path, notice: 'Modeling order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end
  end
end
