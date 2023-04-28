# frozen_string_literal: true

module Admin
  class ProductCategoriesController < BaseController
    def index
      @pagy, @product_categories = pagy(ProductCategory.all, items: 10)
    end
  end
end
