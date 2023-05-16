# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @product_categories = ProductCategory.all
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
