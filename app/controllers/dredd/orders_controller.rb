# frozen_string_literal: true

module Dredd
  class OrdersController < BaseController
    def index
      @pagy, @orders = pagy(Order.all, items: 10)
    end

    def show; end
  end
end
