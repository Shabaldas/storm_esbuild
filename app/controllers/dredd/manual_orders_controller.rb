# frozen_string_literal: true

module Dredd
  class ManualOrdersController < BaseController
    def index
      @pagy, @manual_orders = pagy(ManualOrder.all, items: 20)
    end

    def show; end
  end
end
