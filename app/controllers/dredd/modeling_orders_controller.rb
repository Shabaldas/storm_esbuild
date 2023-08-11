# frozen_string_literal: true

module Dredd
  class ModelingOrdersController < BaseController
    before_action :set_modeling_order, only: [:edit, :update, :destroy]

    def index
      @pagy, @modeling_orders = pagy(ModelingOrder.all, items: 20)
    end

    def edit; end

    def update
      if @modeling_order.update(modleing_order_params)
        redirect_to dredd_modeling_orders_path, notice: 'Modeling order was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @modeling_order.destroy
      redirect_to dredd_modeling_orders_path, notice: 'Modeling order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def modleing_order_params
      params.require(:modeling_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, :total_price, :deadline, :status,
                                             files: [])
    end

    def set_modeling_order
      @modeling_order = ModelingOrder.find(params[:id])
    end
  end
end
