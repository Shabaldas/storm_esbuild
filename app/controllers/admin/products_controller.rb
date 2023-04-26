# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    def index
      @products = Product.all
    end
  end
end
