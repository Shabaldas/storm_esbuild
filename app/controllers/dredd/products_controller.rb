# frozen_string_literal: true

module Dredd
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :destroy]

    def index
      @pagy, @products = pagy(Product.all, items: 10)
    end

    def show; end

    def new
      @product = Product.new
      @product.build_primary_product_option(product: @product)
      @product.build_secondary_product_option(product: @product)
    end

    def edit; end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to dredd_products_path, notice: { text: 'Product was successfully created.', icon: 'success_icon' }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      redirect_to dredd_products_path, error: { text: 'Product was successfully destroyed.', icon: 'attention' }
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :product_category_id, :price, :status, :main_picture,
                                      primary_product_option_attributes: [:id, :option_id, :primary, :_destroy,
                                                                          { product_option_values_attributes: [:id, :option_value_id, :price, :_destroy] }],
                                      secondary_product_option_attributes: [:id, :option_id, :primary, :_destroy,
                                                                            { product_option_values_attributes: [:id, :option_value_id, :price, :_destroy] }])
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
