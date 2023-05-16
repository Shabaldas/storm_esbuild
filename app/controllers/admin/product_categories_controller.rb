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
      @product_category = ProductCategory.new(product_category_params.except(:ancestry, :children))

      if @product_category.save
        parent_id = product_category_params[:ancestry]
        @product_category.update!(ancestry: parent_id) if parent_id.present?

        redirect_to admin_product_categories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def product_category_params
      params.require(:product_category).permit(:name, :description, :ancestry, children: [])
    end
  end
end
