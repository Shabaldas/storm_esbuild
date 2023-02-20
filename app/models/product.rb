# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :product_category

  enum status: { inactive: 0, active: 1 }
end
