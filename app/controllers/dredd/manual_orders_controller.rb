# frozen_string_literal: true

module Dredd
  class ManualOrdersController < BaseController
    before_action :set_manual_order, only: [:edit, :update, :destroy]

    def index
      @pagy, @manual_orders = pagy(ManualOrder.order(print_code: :asc), items: 20)
    end

    def new
      @manual_order = ManualOrder.new
    end

    def edit; end

    def create
      @manual_order = ManualOrder.new(manual_order_params)

      if @manual_order.save
        redirect_to dredd_manual_orders_path, notice: 'Manual order was successfully created' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @manual_order.update(manual_order_params)
        redirect_to dredd_manual_orders_path, notice: 'Manual Order was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @manual_order.destroy
      redirect_to dredd_manual_orders_path, notice: 'Manual Order was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def manual_order_params
      params.require(:manual_order).permit(:print_code, :first_name, :last_name, :email, :phone_number, :app_contact, :count,
                                           :price_for_modeling, :price_for_printing, :prepaid_expense, :status, :total_price, :comment,
                                           :print_material, :print_color, :deadline, :printing_time_for_one_item, :quality, :infill)
    end

    def set_manual_order
      @manual_order = ManualOrder.find(params[:id])
    end
  end
end
