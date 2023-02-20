# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy
  has_ancestry

  validates :name, presence: true
end
