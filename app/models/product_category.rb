# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy
  has_ancestry

  scope :select_tree, ->(id) { where.not(id:).arrange }
  scope :only_parents, -> { where(ancestry: nil) }
  scope :only_children, -> { where.not(ancestry: nil) }

  validates :name, :description, presence: true
end
