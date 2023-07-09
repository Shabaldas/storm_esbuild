# frozen_string_literal: true

module Dredd
  class DashboardController < BaseController
    def index
      @users_count = User.count
      @new_orders = Order.unpaid.count
      @new_feedback_calls = FeedbackCall.where(processed: false).count
    end
  end
end
