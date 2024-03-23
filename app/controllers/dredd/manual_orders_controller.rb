# frozen_string_literal: true

module Dredd
  class ManualOrdersController < BaseController
    before_action :set_manual_order, only: [:edit, :update, :destroy]

    def index
      @q = ManualOrder.includes([:client]).order(status: :asc, print_code: :desc).ransack(params[:q])
      @pagy, @manual_orders = pagy(@q.result(distinct: true), items: 30)
    end

    def new_manual_order
      @manual_order = ManualOrder.new
    end

    def new_manual_order_from_client
      @manual_order = ManualOrder.new
    end

    def edit; end

    def create
      @manual_order = ManualOrder.new(manual_order_params)

      if manual_order_params[:client_id].present?
        client = Client.find(manual_order_params[:client_id])
        @manual_order.first_name = client&.first_name
        @manual_order.last_name = client&.last_name
        @manual_order.email = client&.email
        @manual_order.phone_number = client&.phone_number
      else
        @client = Client.new(first_name: manual_order_params[:first_name],
                             last_name: manual_order_params[:last_name],
                             email: manual_order_params[:email],
                             phone_number: manual_order_params[:phone_number])
        @manual_order.client = @client
      end

      if @manual_order.save
        @client.save if manual_order_params[:client_id].blank?

        redirect_to dredd_manual_orders_path, status: :see_other, notice: { text: 'Manual order was successfully created', icon: 'success_icon' }
      else
        return render :new_manual_order, status: :unprocessable_entity if params[:new_or_old] == 'new'

        render :new_manual_order_from_client, status: :unprocessable_entity
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

      redirect_to dredd_manual_orders_path, notice: { text: 'Manual Order was successfully destroyed.', icon: 'attention' }
    end

    private

    def manual_order_params
      params.require(:manual_order).permit(:print_code, :first_name, :client_id, :last_name, :email, :phone_number, :app_contact, :count,
                                           :need_to_call_client, :price_for_modeling, :price_for_printing,
                                           :prepaid_expense, :status, :total_price, :comment, :worker_id,
                                           :print_material, :print_color, :deadline, :workflow_status,
                                           :printing_time_for_one_item, :quality, :infill, :end_date,
                                           :individual_entrepreneur_accountings)
    end

    def set_manual_order
      @manual_order = ManualOrder.find(params[:id])
    end
  end
end
