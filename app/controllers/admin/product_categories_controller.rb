# frozen_string_literal: true

module Admin
  class ProductCategoriesController < BaseController
    def index
      @product_categories = ProductCategory.all
    end
  end
end
