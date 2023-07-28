# frozen_string_literal: true

module Dredd
  class PrintingOrdersController < BaseController
    def index
      @pagy, @printing_orders = pagy(ModelingOrder.all, items: 20)
    end
  end
end
