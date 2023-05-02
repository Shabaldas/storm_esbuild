# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    def index
      @pagy, @products = pagy(Product.all, items: 10)
    end

    def show
      @product = Product.find(params[:id])
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
      params.require(:product).permit(:name, :description, :product_category_id, :status, :price,
                                      product_options_attributes: [:id, :option_id, :primary, :_destroy, { product_option_values_attributes: [:id, :option_value_id, :price, :_destroy] }])
    end
  end
end
