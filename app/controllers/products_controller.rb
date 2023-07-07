# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authorize_admin

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
    @cart_item = @product.cart_items.build
    @cart_item_option_value = @cart_item.cart_item_option_values.build
    @suggest_products = Product.all.sample(5)
  end

  private

  def authorize_admin
    authorize :admin, :access?
  end
end
