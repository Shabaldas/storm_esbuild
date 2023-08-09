# frozen_string_literal: true

module Dredd
  class RenderingOrdersController < BaseController
    before_action :set_rendering_order, only: [:edit, :update, :destroy]

    def index
      @pagy, @rendering_orders = pagy(RenderingOrder.all, items: 20)
    end

    def edit; end

    def update
      if @rendering_order.update(rendering_order_params)
        redirect_to dredd_rendering_orders_path, notice: 'Rendering order was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @rendering_order.destroy
      redirect_to dredd_rendering_orders_path, notice: 'Rendering order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def rendering_order_params
      params.require(:rendering_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, :total_price, :deadline, :status,
                                              files: [])
    end

    def set_rendering_order
      @rendering_order = RenderingOrder.find(params[:id])
    end
  end
end
