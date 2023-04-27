# frozen_string_literal: true

module Admin
  class ProductCategoriesController < BaseController
    def index
      @pagy, @product_categories = pagy(ProductCategory.all)
    end
  end
end
