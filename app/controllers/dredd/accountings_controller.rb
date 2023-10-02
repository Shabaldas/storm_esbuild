# frozen_string_literal: true

module Dredd
  class AccountingsController < BaseController
    def index
      @all_paid_manual_orders = ManualOrder.paid
    end

    def monthly
      return if params['date'].blank?

      @cost = Cost.new
      @formated_date = Date.strptime(params['date'], '%m/%Y')
      @earnings_from_selected_month = earnings_from_manual_orders[params['date']]
      @costs_from_selected_month = costs_from_all_users[params['date']]
    end

    private

    helper_method :earnings_from_manual_orders
    def earnings_from_manual_orders
      @earnings_from_manual_orders ||= ManualOrder.paid.group_by { |order| [order.end_date&.month, order.end_date&.year].join('/') }
    end

    helper_method :costs_from_all_users
    def costs_from_all_users
      @costs_from_all_users ||= Cost.all.group_by { |cost| [cost.date&.month, cost.date&.year].join('/') }
    end

    helper_method :costs_from_all_users_for_current_month
    def costs_from_all_users_for_current_month
      costs_from_all_users[Time.current.strftime('%-m/%Y')]
    end

    helper_method :earnings_from_manual_orders_for_current_month
    def earnings_from_manual_orders_for_current_month
      earnings_from_manual_orders[Time.current.strftime('%-m/%Y')]
    end

    helper_method :accountings_data_for_last_six_months
    def accountings_data_for_last_six_months
      current_month = Time.current.beginning_of_month.to_date
      last_six_months = (1..6).map { |i| (current_month - i.months).beginning_of_month.strftime('%-m/%Y') }

      @accountings_data_for_last_six_months ||=
        last_six_months.map do |month|
          total_earnings = (earnings_from_manual_orders[month] || []).sum(&:total_price)
          total_costs = (costs_from_all_users[month] || []).sum(&:amount)
          [month, total_earnings, total_costs]
        end
    end
  end
end
