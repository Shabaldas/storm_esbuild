# frozen_string_literal: true

module Api::V1::Resources
  class ProductCategories < Grape::API
    include Api::V1::Concerns::ListParamsHelper

    resource :product_categories do
      desc 'Return list of all product categories'
      params do
        use :list_params, limit_default: 10, limit_max: 100
      end
      get do
        declared_params = declared(params, include_missing: false)
        categories = ProductCategory.arrange_serializable

        present categories.take(declared_params[:limit]),
                with: Entities::V1::ProductCategories,
                has_more: categories.size > declared_params[:limit]
      end
    end
  end
end
