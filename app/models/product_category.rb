# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy
  has_ancestry

  scope :select_tree, ->(id) { where.not(id:).arrange }

  validates :name, :description, presence: true
end
