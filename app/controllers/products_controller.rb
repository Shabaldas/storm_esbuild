# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @product_categories = ProductCategory.all
    @one_category = ProductCategory.first
    @parents_product_categories = ProductCategory.where(ancestry: nil)
  end
end
