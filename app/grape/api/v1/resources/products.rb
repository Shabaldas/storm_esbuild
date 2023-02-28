# frozen_string_literal: true

module Api::V1::Resources
  class Products < Grape::API
    include Api::V1::Concerns::ListParamsHelper

    resource :products do
      desc 'Return list of all product categories'
      params do
        use :list_params, limit_default: 50, limit_max: 200
      end
      get do
        declared_params = declared(params, include_missing: false)
        products = Product.all
                     .before(declared_params[:before])
                     .after(declared_params[:after])
                     .load

        present products.take(declared_params[:limit]),
                with: Entities::V1::Products,
                has_more: products.size > declared_params[:limit]
      end
    end
  end
end
