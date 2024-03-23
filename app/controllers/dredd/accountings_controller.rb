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
      @reward_workers_for_selected_month = monthly_worker_reward[params['date']]
      @costs_from_selected_month = costs_from_all_users[params['date']]
    end

    private

    helper_method :earnings_from_manual_orders
    def earnings_from_manual_orders
      @earnings_from_manual_orders ||= ManualOrder.paid.group_by { |order| [order.end_date&.month, order.end_date&.year].join('/') }
    end

    def reward_for_workers_by_manual_orders
      @reward_for_workers_by_manual_orders ||= ManualOrder.paid.includes([:worker]).where.not(worker_id: nil).group_by do |order|
        [order.end_date&.month, order.end_date&.year].join('/')
      end
    end

    def monthly_worker_reward
      @monthly_worker_reward ||= reward_for_workers_by_manual_orders.transform_values do |manual_order_this_month|
        manual_order_this_month.group_by { |order| order.worker&.first_name }
      end
    end

    helper_method :monthly_worker_reward_for_current_month
    def monthly_worker_reward_for_current_month
      monthly_worker_reward[Time.current.strftime('%-m/%Y')]
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
          total_reward = (monthly_worker_reward[month] || {}).values.flatten.map(&:price_for_modeling)&.compact&.sum
          [month, total_earnings, total_costs, total_reward]
        end
    end
  end
end
