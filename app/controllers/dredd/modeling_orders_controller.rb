# frozen_string_literal: true

module Dredd
  class ModelingOrdersController < BaseController
    def index
      @pagy, @modeling_orders = pagy(ModelingOrder.all, items: 20)
    end
  end
end
