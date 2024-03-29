# frozen_string_literal: true

module Dredd
  class CostsController < BaseController
    before_action :set_cost, only: :destroy

    def create
      @cost = Cost.new(cost_params)
      @cost.user = current_user

      if @cost.save
        redirect_to monthly_dredd_accountings_path(date: params[:cost][:month_date]), info: { text: 'Cost created', icon: 'success_icon' }
      else
        redirect_to monthly_dredd_accountings_path(date: params[:cost][:month_date]), error: { text: 'Cost not created', icon: 'attention' }
      end
    end

    def destroy
      @cost.destroy!
      redirect_to monthly_dredd_accountings_path(date: params[:month_date]), info: { text: 'Cost deleted', icon: 'success_icon' }
    end

    private

    def cost_params
      params.require(:cost).permit(:name, :user, :description, :amount, :date)
    end

    def set_cost
      @cost = Cost.find(params[:id])
    end
  end
end
