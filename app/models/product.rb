# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :product_category
  has_many :product_options, dependent: :destroy
  has_many :options, through: :product_options
  has_many :product_option_values, through: :product_options, dependent: :destroy
  has_many :option_values, through: :product_option_values, source: :option_value

  accepts_nested_attributes_for :product_options, allow_destroy: true
  accepts_nested_attributes_for :product_option_values, allow_destroy: true

  enum status: { inactive: 0, active: 1 }

  validates :name, :description, presence: true

  # API scopes
  scope :before, ->(id) { where('products.id < ?', id).order(id: :desc) if id.present? }
  scope :after, ->(id) { where('products.id > ?', id).order(id: :asc) if id.present? }
end
