# frozen_string_literal: true

module Dredd
  class AccountingsController < BaseController
    def index
      @all_paid_manual_orders = ManualOrder.paid
    end

    def monthly
      return if params['date'].blank?

      parsed_date = Date.strptime(params['date'], '%m/%Y')
      @formated_date = parsed_date.strftime('%B %Y')
      @earnings_from_selected_month = earnings_from_manual_orders[params['date']]
    end

    private

    helper_method :earnings_from_manual_orders
    def earnings_from_manual_orders
      @earnings_from_manual_orders ||= ManualOrder.paid.group_by { |order| [order.updated_at.month, order.updated_at.year].join('/') }
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
          [month, total_earnings]
        end
    end
  end
end
