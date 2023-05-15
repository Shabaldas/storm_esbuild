# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :product_category
  has_one_attached :main_picture
  has_many :product_options, dependent: :destroy
  has_many :options, through: :product_options
  has_many :product_option_values, through: :product_options, dependent: :destroy
  has_many :option_values, through: :product_option_values, source: :option_value

  # helpers relationship
  has_one :primary_product_option, ->(_where) { where primary: true }, class_name: 'ProductOption', dependent: :destroy # rubocop:disable  Rails/InverseOf
  has_one :secondary_product_option, ->(_where) { where primary: false }, class_name: 'ProductOption', dependent: :destroy # rubocop:disable  Rails/InverseOf

  accepts_nested_attributes_for :product_options, allow_destroy: true
  accepts_nested_attributes_for :product_option_values, allow_destroy: true

  enum status: { inactive: 0, active: 1 }

  validates :name, :description, :main_picture, presence: true

  # API scopes
  scope :before, ->(id) { where('products.id < ?', id).order(id: :desc) if id.present? }
  scope :after, ->(id) { where('products.id > ?', id).order(id: :asc) if id.present? }

  def product_colors
    product_option_values.joins(:product_option).where(product_options: { id: primary_product_option.id })
  end

  def product_sizes
    product_option_values.joins(:product_option).where(product_options: { id: secondary_product_option.id })
  end
end
