# frozen_string_literal: true

module Dredd
  class ScanningOrdersController < BaseController
    before_action :set_scanning_order, only: [:edit, :update, :destroy]

    def index
      @pagy, @scanning_orders = pagy(ScanningOrder.all, items: 20)
    end

    def edit; end

    def update
      if @scanning_order.update(scanning_order_params)
        redirect_to dredd_scanning_orders_path, notice: { text: 'Scanning order was successfully updated.', icon: 'success_icon' }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @scanning_order.destroy
      redirect_to dredd_scanning_orders_path, error: { text: 'Scanning order was successfully destroyed.', icon: 'attention' }
    end

    private

    def scanning_order_params
      params.require(:scanning_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, :total_price, :deadline, :status,
                                             files: [])
    end

    def set_scanning_order
      @scanning_order = ScanningOrder.find(params[:id])
    end
  end
end
