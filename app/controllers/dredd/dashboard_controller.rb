# frozen_string_literal: true

module Dredd
  class DashboardController < BaseController
    def index
      @users_count = User.count
      @shop_orders = Order.all
      @manual_orders = ManualOrder.all
      @modeling_orders = ModelingOrder.all
      @rendering_orders = RenderingOrder.all
      @printing_orders = PrintingOrder.all
      @new_feedback_calls = FeedbackCall.all
      @clients_count = Client.count
    end
  end
end
