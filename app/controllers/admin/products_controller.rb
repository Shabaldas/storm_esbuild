# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :destroy]

    def index
      @pagy, @products = pagy(Product.all, items: 10)
    end

    def show; end

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path, notice: 'Product was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path, notice: 'Product was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :product_category_id, :status, :main_picture)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
