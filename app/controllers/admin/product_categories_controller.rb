# frozen_string_literal: true

module Admin
  class ProductCategoriesController < BaseController
    def index
      @pagy, @product_categories = pagy(ProductCategory.all, items: 10)
    end

    def show
      @product_category = ProductCategory.find(params[:id])
    end

    def new
      @product_categories = ProductCategory.all
      @product_category = ProductCategory.new
    end

    def create
      binding.irb
      @product_category = ProductCategory.new(check_parent_id)
      if @product_category.save
        redirect_to admin_product_categories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def check_parent_id
      if product_category_params['parent'].present?
        result = {}
        product_category_params.each do |key, value|
          result[key.to_sym] = if key == 'parent'
                                 ProductCategory.find(value)
                               else
                                 value
                               end
        end
        result
      else
        product_category_params
      end
    end

    def product_category_params
      params.require(:product_category).permit(:name, :description, :parent)
    end
  end
end
