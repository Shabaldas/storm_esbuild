# frozen_string_literal: true

class ProductsController < ApplicationController
  include Pagy::Backend
  def index
    @product_categories = ProductCategory.all
    # @one_category = ProductCategory.first
    search_params = params.permit(:format, :page, q: [:name_cont, product_category_id_eq_any: []])
    @parents_product_categories = ProductCategory.where(ancestry: nil)
    @q = Product.ransack(search_params[:q])
    products = @q.result(distinct: true).order(created_at: :asc)
    @pagy, @products = pagy_countless(products, items: 12)
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  # standard_sizes_id_eq_any_cont
  # def search_params
  #   params.permit(:format, :page, q: [:name_cont, :product_category_id_cont])
  #   params.require(:q).permit!
  # end
end
