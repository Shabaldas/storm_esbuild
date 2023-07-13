# frozen_string_literal: true

module Dredd
  class DashboardController < BaseController
    def index
      @users_count = User.count
      @orders = Order.all
      @manual_orders = ManualOrder.all
      @new_feedback_calls = FeedbackCall.where(processed: false).count
    end
  end
end
