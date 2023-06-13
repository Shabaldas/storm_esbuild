# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @product_categories = ProductCategory.where(ancestry: nil)
    @q = Product.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true), items: 12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @product = Product.find(params[:id])
    @suggest_products = Product.all.sample(5)
  end
end
