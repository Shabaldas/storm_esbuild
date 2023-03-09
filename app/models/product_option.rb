# frozen_string_literal: true

class ProductOption < ApplicationRecord
  belongs_to :product, inverse_of: :product_options
  belongs_to :option, inverse_of: :product_options

  has_many :product_option_values, dependent: :destroy

  accepts_nested_attributes_for :product_option_values, allow_destroy: true
end
