# frozen_string_literal: true

module Dredd
  class ManualOrdersController < BaseController
    before_action :set_manual_order, only: [:edit, :update, :destroy]

    def index
      @q = manual_orders_for_role
      @pagy, @manual_orders = pagy(@q.result(distinct: true), items: 20)
    end

    def new
      @manual_order = ManualOrder.new
    end

    def edit; end

    def create
      @manual_order = ManualOrder.new(manual_order_params)

      if @manual_order.save
        redirect_to dredd_manual_orders_path, notice: { text: 'Manual order was successfully created', icon: 'success_icon' }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @manual_order.update(manual_order_params)
        redirect_to edit_dredd_manual_order_path(@manual_order), notice: { text: 'Manual Order was successfully updated.', icon: 'success_icon' }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @manual_orders = ManualOrder.order(status: :asc, print_code: :desc)
      @manual_order.destroy!

      respond_to do |format|
        format.html do
          redirect_to dredd_manual_orders_path, info: { text: 'Manual Order was successfully destroyed.', icon: 'attention' }
        end
        format.turbo_stream { flash.now[:info] = { text: 'Manual Order was successfully destroyed.', icon: 'success_icon' }.stringify_keys }
      end
    end

    private

    def manual_order_params
      params.require(:manual_order).permit(:print_code, :first_name, :last_name, :email, :phone_number, :app_contact, :count,
                                           :need_to_call_client, :price_for_modeling, :price_for_printing,
                                           :prepaid_expense, :status, :total_price, :comment, :worker_id,
                                           :print_material, :print_color, :deadline, :workflow_status,
                                           :printing_time_for_one_item, :quality, :infill, :end_date,
                                           :individual_entrepreneur_accountings)
    end

    def set_manual_order
      @manual_order = ManualOrder.find(params[:id])
    end

    def manual_orders_for_role
      if current_user.manager?
        ManualOrder.unpaid.order(status: :asc, print_code: :desc).ransack(params[:q]&.permit!)
      else
        ManualOrder.order(status: :asc, print_code: :desc).ransack(params[:q]&.permit!)
      end
    end
  end
end
