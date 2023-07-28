# frozen_string_literal: true

module Dredd
  class RenderingOrdersController < BaseController
    def index
      @pagy, @rendering_orders = pagy(ModelingOrder.all, items: 20)
    end
  end
end
