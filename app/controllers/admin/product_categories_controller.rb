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
      @product_category = ProductCategory.new
    end


    def create
      @product_category = ProductCategory.new(product_category_params)
      if @product_category.save
        redirect_to admin_product_categories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def product_category_params
      params.require(:product_category).permit(:name, :description)
    end
  end
end
