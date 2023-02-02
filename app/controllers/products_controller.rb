# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end
end
