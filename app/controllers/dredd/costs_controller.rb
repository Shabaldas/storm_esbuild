# frozen_string_literal: true

module Dredd
  class DashboardController < BaseController
    def create
      @cost = Cost.new(cost_params)
      if @cost.save
        redirect_to dredd_dashboard_index_path, info: 'Cost created'
      else
        redirect_to dredd_dashboard_index_path, error: 'Cost not created'
      end
    end

    private

    def cost_params
      params.require(:cost).permit(:name, :user, :description, :amount, :date)
    end
  end
end
