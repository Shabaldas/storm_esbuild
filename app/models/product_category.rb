# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_ancestry

  validates :name, presence: true
end
