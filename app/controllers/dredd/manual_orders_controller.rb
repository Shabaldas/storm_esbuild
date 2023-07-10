# frozen_string_literal: true

module Dredd
  class ManualOrdersController < BaseController
    before_action :set_manual_order, only: [:show, :destroy]

    def index
      @pagy, @manual_orders = pagy(ManualOrder.all, items: 20)
    end

    def show; end

    def new
      @manual_order = ManualOrder.new
    end

    def destroy
      @manual_order.destroy
      redirect_to dredd_manual_orders_path, notice: 'Manual Order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def set_manual_order
      @manual_order = ManualOrder.find(params[:id])
    end
  end
end
