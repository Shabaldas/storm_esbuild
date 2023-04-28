# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    def index
      @pagy, @products = pagy(Product.all, items: 10)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :product_category_id, :status)
    end
  end
end
