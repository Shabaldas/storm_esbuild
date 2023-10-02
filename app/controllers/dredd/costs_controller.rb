# frozen_string_literal: true

module Dredd
  class CostsController < BaseController
    def create
      @cost = Cost.new(cost_params)
      @cost.user = current_user

      if @cost.save
        redirect_to monthly_dredd_accountings_path(date: params[:cost][:month_date]), info: 'Cost created'
      else
        redirect_to monthly_dredd_accountings_path(date: params[:cost][:month_date]), error: 'Cost not created'
      end
    end

    private

    def cost_params
      params.require(:cost).permit(:name, :user, :description, :amount, :date)
    end
  end
end
