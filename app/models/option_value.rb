# frozen_string_literal: true

class OptionValue < ApplicationRecord
  belongs_to :option
  has_many :product_option_values, dependent: :destroy, inverse_of: :option_value
end
