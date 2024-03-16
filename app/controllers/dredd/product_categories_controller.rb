# frozen_string_literal: true

module Dredd
  class ProductCategoriesController < BaseController
    before_action :set_product_category, only: [:show, :edit, :destroy]

    def index
      @pagy, @product_categories = pagy(ProductCategory.all, items: 10)
    end

    def show; end

    def new
      @product_category = ProductCategory.new
    end

    def edit; end

    def create
      @product_category = ProductCategory.new(product_category_params.except(:ancestry))

      parent_id = product_category_params[:ancestry]

      if parent_id.present?
        parent_category = ProductCategory.find_by(id: parent_id)
        parent_category.children.create!(product_category_params.except(:ancestry))

        redirect_to dredd_product_categories_path, notice: { text: 'Product category was successfully created.', icon: 'success_icon' }
      elsif @product_category.save
        redirect_to dredd_product_categories_path, notice: { text: 'Product category was successfully created.', icon: 'success_icon' }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @product_category.destroy
      redirect_to dredd_product_categories_path, error: { text: 'Product category was successfully destroyed.', icon: 'attention' }
    end

    private

    def product_category_params
      params.require(:product_category).permit(:name, :description, :ancestry)
    end

    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end
  end
end
