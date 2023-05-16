# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @product_categories = ProductCategory.all
    @pagy, @products = pagy(Product.all, items: 12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
