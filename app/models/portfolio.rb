# frozen_string_literal: true

class Portfolio < ApplicationRecord
  has_one_attached :main_picture

  enum status: { inactive: 0, active: 1 }
  enum portfolio_type: { modeling: 0, rendering: 1, printing: 2 }

  validates :name, :main_picture, presence: true

  translates :name, :category_name, :description
end
