# frozen_string_literal: true

module Api::V1::Resources
  class ProductCategories < Grape::API
    resource :product_categories do
      desc 'Return list of all product categories'
      get do
        categories = ProductCategory.arrange_serializable

        present categories
      end
    end
  end
end
