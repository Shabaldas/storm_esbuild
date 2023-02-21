# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ProductOptionsSeed
      def execute
        # Existing Options
        size_option = Option.find_by(id: 1, title: 'Size', measurement: :mm)
        color_option = Option.find_by(id: 2, title: 'Color', measurement: :color)

        # Product_for_parent_category
        Product.first(8).each do |product|
          # seed only colors option
          seed_color_product_options(color_option, product)
        end

        Product.where(id: 23..40).each do |product|
          # seed only size option
          seed_size_product_options(size_option, product)
        end

        Product.where(id: 41..54).each do |product|
          # seed colors&size options
          seed_color_product_options(color_option, product)
          seed_size_product_options(size_option, product)
        end

        # Product_for_child_category
        Product.last(50).each do |product|
          # seed colors&size options
          seed_color_product_options(color_option, product)
          seed_size_product_options(size_option, product)
        end
      end

      private

      def seed_size_product_options(option, product)
        option.option_values.pluck(:value).each.with_index(1) do |option_value, index|
          product.product_options.find_or_create_by(option:).product_option_values.find_or_create_by!(
            option_value: option.option_values.find_by(value: option_value),
            price: 10.0 * index
          )
        end
      end

      def seed_color_product_options(option, product)
        option.option_values.pluck(:value).each do |option_value|
          product.product_options.find_or_create_by(option:, primary: true).product_option_values.find_or_create_by!(
            option_value: option.option_values.find_by(value: option_value)
          )
        end
      end
    end
  end
end
